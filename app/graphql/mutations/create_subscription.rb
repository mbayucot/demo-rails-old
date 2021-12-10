module Mutations
  class CreateSubscription < BaseMutation
    field :subscription, Types::SubscriptionType, null: false
    field :errors, [Types::UserErrorType], null: true

    # TODO: define arguments
    argument :token, String, required: true

    # TODO: define resolve method
    def resolve(token:)
      user = context[:current_user]

      begin
        Subscription.transaction do
          plan = Stripe::Plan.list.data.first.id
          item = { price: plan }

          Stripe::Customer.update(
            user.stripe_customer_id,
            { source: token }
          )

          stripe_subscription = Stripe::Subscription.create(
            {
              customer: user.stripe_customer_id,
              items: [item]
            }
          )
          subscription = user.subscriptions.create!(stripe_subscription_id: stripe_subscription.id,
                                     current_period_start: Time.at(stripe_subscription.current_period_start),
                                     current_period_end: Time.at(stripe_subscription.current_period_end),
                                     status: Subscription.statuses[:active])

          {
            subscription: subscription,
            errors: [],
          }
        end
      rescue StandardError => e
        raise GraphQL::ExecutionError.new("Stripe Error", extensions: { error: e.message})
      end
    end
  end
end
