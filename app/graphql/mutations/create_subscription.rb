module Mutations
  class CreateSubscription < BaseMutation
    # TODO: define return fields
    field :user, Types::UserType, null: false
    field :errors, [Types::UserErrorType], null: false

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
            { source: token}
          )

          subscription = Stripe::Subscription.create(
            {
              customer: user.stripe_customer_id,
              items: [item]
            }
          )
          user.subscriptions.create!(stripe_subscription_id: subscription.id, start_at: subscription.current_period_start)
        end
        {
          user: user,
          errors: [],
        }
      rescue StandardError => e
        Rails.logger.debug e.message
        {
          user: user,
          errors: [e.message],
        }
      end
    end
  end
end
