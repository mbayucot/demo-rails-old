module StripeInteractors
  class CreateSubscription < BaseInteractor
    def call
      user = User.find_by!(stripe_customer_id: context.subscription.customer)
      context.subscription = user.subscriptions.create!(
        stripe_subscription_id: context.subscription.id,
        status: context.subscription.status,
        cancel_at_period_end: context.subscription.cancel_at_period_end,
        current_period_start: Time.at(context.subscription.current_period_start),
        current_period_end: Time.at(context.subscription.current_period_end)
      )
    rescue StandardError => e
      context.fail!(message: e.message)
    end
  end
end
