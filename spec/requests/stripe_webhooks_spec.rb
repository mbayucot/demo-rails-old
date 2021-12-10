require 'rails_helper'
require 'stripe_mock'

RSpec.describe '/stripe/webhooks', type: :request do
  let(:stripe_helper) { StripeMock.create_test_helper }

  let(:user) { create(:user, email: Faker::Internet.email) }
  let(:subscription) do
    OpenStruct.new(
      id: 'fakeid',
      customer_email: user.email,
      status: 'trial',
      cancel_at_period_end: true,
      current_period_start: DateTime.now.to_time.to_i,
      current_period_end: Faker::Date.forward(days: 30).to_time.to_i
    )
  end

  def bypass_event_signature(payload, subscription = true)
    if subscription
      expect(Stripe::Subscription).to receive(:retrieve).and_return(
        :subscription
      )
    end
    event =
      Stripe::Event.construct_from(JSON.parse(payload, symbolize_names: true))
    expect(Stripe::Webhook).to receive(:construct_event).and_return(event)
  end

  before(:all) do
    Stripe.api_key = 'apikey'
    StripeMock.start
  end
  after(:all) { StripeMock.stop }

  describe 'customer.subscription.updated' do
    let(:payload) do
      StripeMock.mock_webhook_event('customer.subscription.updated').to_json
    end
    before(:each) { bypass_event_signature payload, false }

    it 'is successful' do
      post '/stripe/webhooks', params: payload
      expect(response.code).to eq '200'
    end
  end
end
