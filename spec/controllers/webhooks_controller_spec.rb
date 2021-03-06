require 'rails_helper'

RSpec.describe WebhooksController, type: :controller do
  before do
    Timecop.freeze(Time.local(2015, 4, 23, 0, 46, 0))
  end

  let(:subscription) { Fabricate(:subscription, customer_id: "foo_000") }

  describe "POST #index" do
    it 'returns http success on an empty request' do
      post :index
      expect(response).to have_http_status(:success)
    end

    it 'return nothing on a fake event request' do
      post :index, { id: 'fake' }.to_json
      expect(response).to have_http_status(:success)
    end

    it 'updates local subscription on successful payment' do
      event = StripeMock.mock_webhook_event('invoice.payment_succeeded', {
        customer: subscription.customer_id
      })

      stub(Stripe::Event).retrieve { event }
      post :index, event.to_json

      expect(response).to have_http_status(:success)
      expect(subscription.reload.active_until).to eq 30.days.from_now
    end

    it 'adds friend discount when an invoice is generated' do
      skip 'Broken test'

      event = StripeMock.mock_webhook_event('invoice.created', {
        customer: subscription.customer_id,
        closed: false
      })

      stub(Stripe::Event).retrieve { event }
      mock(Stripe::InvoiceItem).create(is_a(Hash))

      post :index, event.to_json
    end

    it 'does not add friend discount when an invoice with an empty charge is generated' do
      event = StripeMock.mock_webhook_event('invoice.created', {
        customer: subscription.customer_id,
        total: 0
      })

      stub(Stripe::Event).retrieve { event }
      stub(Stripe::InvoiceItem).create(is_a(Hash)) { raise 'Friend discount added for 0 charge invoice' }

      expect { post :index, event.to_json }.to_not raise_error
    end

    it 'notifies admins when a payment fails' do
      event = StripeMock.mock_webhook_event('invoice.payment_failed', {
        customer: subscription.customer_id
      })

      Fabricate(:user, role: User::ROLES[:admin])

      stub(Stripe::Event).retrieve { event }

      post :index, event.to_json

      expect(ActionMailer::Base.deliveries.empty?).to be false
    end
  end
end
