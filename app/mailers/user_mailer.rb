class UserMailer < ApplicationMailer
  helper ApplicationHelper

  def billing_email(user, time = Time.now)
    @user                = user
    @new_users           = User.created_after_date(time - 30.days)
    @num_users           = User.count
    @subscription        = user.subscription
    @num_connections     = @user.friends.count('distinct to_id')
    @num_new_connections = @user.friends.where('friend_edges.created_at > ?', time - 30.days).count('distinct to_id')

    unless @subscription.customer_id.blank?
      stripe_customer = Stripe::Customer.retrieve(@subscription.customer_id)
      @card_num       = stripe_customer.sources.retrieve(stripe_customer.default_source).last4
    else
      @card_num = 4242
    end

    @discounted_total = @subscription.plan.value - (@user.discount / 12)

    if @discounted_total.cents < 0
      @discounted_total = Money.new(0, 'GBP')
    end

    @ascii_table = Terminal::Table.new rows: [
      ['Membership Tier:', @subscription.plan.name, @subscription.plan.value.format(symbol_before_without_space: false, sign_before_symbol: true, sign_positive: true)],
      ['Maven Discount:', "#{@num_connections} connections", (@user.discount / -12).format(symbol_before_without_space: false, sign_before_symbol: true, sign_positive: true)],
      ['Total:', '', @discounted_total.format(symbol_before_without_space: false, sign_before_symbol: true, sign_positive: true)]
    ]

    mail to: user.email, subject: "This month at Newspeak House"
  end
end
