module StripeInteractors
  class UpdateSubscription < BaseInteractor
    def call
      subscription = Subscription.find_by!(stripe_subscription_id: context.subscription.id)
      subscription.update!(status: context.subscription.status,
                           cancel_at_period_end: context.subscription.cancel_at_period_end,
                           current_period_start: Time.at(context.subscription.current_period_start),
                           current_period_end: Time.at(context.subscription.current_period_end))
      context.subscription = subscription
    rescue StandardError => e
      context.fail!(message: e.message)
    end
  end
end
