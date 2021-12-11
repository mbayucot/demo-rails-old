require 'rails_helper'

RSpec.describe Stripe::CreateCustomer do
  let(:user) { create(:user) }

  before(:all) do
    Stripe.api_key = 'apikey'
    StripeMock.start
  end
  after(:all) { StripeMock.stop }

  describe '#call' do
    context 'with valid token' do
      it 'raises an error message' do
        Stripe::CreateCustomer.new(user.id).call
        user.reload
        expect(user.stripe_customer_id).not_to be_nil
      end
    end
  end
end
