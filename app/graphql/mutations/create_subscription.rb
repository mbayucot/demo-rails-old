module Mutations
  class CreateSubscription < BaseMutation
    field :user, Types::UserType, null: false
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

          subscription = Stripe::Subscription.create(
            {
              customer: user.stripe_customer_id,
              items: [item]
            }
          )
          user.subscriptions.create!(stripe_subscription_id: subscription.id,
                                     current_period_start: Time.at(subscription.current_period_start),
                                     current_period_end: Time.at(subscription.current_period_end),
                                     status: Subscription.statuses[:active])
        end

        {
          user: user,
          errors: [],
        }
      rescue StandardError => e
        raise GraphQL::ExecutionError.new("Stripe Error", extensions: e)
      end
    end
  end
end
