module Types
  class SubscriptionType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: false
    field :stripe_subscription_id, String, null: true
    field :status, Integer, null: true
    field :cancel_at_period_end, Boolean, null: false
    field :current_period_start, GraphQL::Types::ISO8601DateTime, null: false
    field :current_period_end, GraphQL::Types::ISO8601DateTime, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
