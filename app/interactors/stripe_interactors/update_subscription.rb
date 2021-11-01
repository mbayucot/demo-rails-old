module StripeInteractors
  class UpdateSubscription < BaseInteractor
    before do
      if context.stripe_sup.blank? && context.invoice.present?
        context.stripe_sub =
          Stripe::Subscription.retrieve(context.invoice.subscription)
      end
    end

    def call
      subscription = Subscription.find_by!(external_id: context.stripe_sub.id)
      stripe_sub = context.stripe_sub
      subscription.update!(status: stripe_sub.status,
                           cancel_at_period_end: stripe_sub.cancel_at_period_end,
                           current_period_start: Time.at(stripe_sub.current_period_start),
                           current_period_end: Time.at(stripe_sub.current_period_end))
      context.subscription = subscription
    rescue StandardError => e
      context.fail!(message: e.message)
    end
  end
end
