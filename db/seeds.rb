ActiveRecord::Base.transaction do
  # Plans
  (0..10).each do |i|
    Plan.create!(name: i == 0 ? 'Basic' : "Sponsor #{i} additional memberships", value: (i + 1) * 2500, stripe_id: "plan_#{i}")
  end

  # Create admin user
  a = User.new({
    :name          => 'Admin',
    :showcase_text => 'The boss of this place',
    :email         => 'admin@localhost',
    :password      => 'admin',
    :role          => User::ROLES[:admin],
    :subscription  => Subscription.new
  })

  a.save!(validate: false)

  # Some events
  Event.create!({
    :name              => 'Game LAN',
    :location          => 'Living room',
    :url               => 'http://example.com',
    :start_at          => 30.days.from_now,
    :end_at            => 31.days.from_now,
    :short_description => 'A *really* cool event',
    :description       => 'This is a **super** long description (but not really)',
    :organiser_name    => 'No one',
    :organiser_email   => 'no@one.com',
    :organiser_url     => 'http://a-man-has-no-name.com',
    :public            => true,
    :status            => :confirmed,
    :notes             => ''
  })

  # Some fellows
  f = User.new({
    :email         => 'user@example.com',
    :password      => 'test',
    :role          => User::ROLES[:fellow],
    :name          => 'John Smith',
    :showcase_text => 'A man in a blue box'
  })

  f.save!(validate: false)
end
