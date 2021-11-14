require 'rails_helper'

RSpec.describe StripeInteractors::UpdateSubscription, type: :interactor do
  let(:user) { create(:user) }
  let(:subscription) { create(:subscription, stripe_subscription_id: 'number') }
  let(:stripe_sub) do
    OpenStruct.new(
      id: subscription.stripe_subscription_id,
      status: 'trialing',
      cancel_at_period_end: true,
      current_period_start: DateTime.now.to_time.to_i,
      current_period_end: Faker::Date.forward(days: 30).to_time.to_i
    )
  end

  subject(:context) do
    StripeInteractors::UpdateSubscription.call(
      subscription: stripe_sub
    )
  end

  describe '.call' do
    context 'when given a valid stripe subscription' do
      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'provides the subscription' do
        expect(context.subscription).to be_present
      end

      it 'provides the stripe_subscription_id' do
        expect(context.subscription.stripe_subscription_id).to eq(stripe_sub.id)
      end
    end

    context 'when given an invalid stripe subscription' do
      let(:context) do
        StripeInteractors::UpdateSubscription.call(stripe_sub: nil, user: user)
      end

      it 'fails' do
        expect(context).to be_a_failure
      end

      it 'provides a failure message' do
        expect(context.message).to be_present
      end
    end
  end
end
