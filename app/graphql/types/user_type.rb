module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :password, String, null: true
    field :encrypted_password, String, null: true
    field :reset_password_token, String, null: true
    field :reset_password_sent_at, GraphQL::Types::ISO8601DateTime, null: true
    field :remember_created_at, GraphQL::Types::ISO8601DateTime, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: true
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
    field :first_name, String, null: true
    field :last_name, String, null: true
    field :role, String, null: true
    field :name, String, null: true
    field :stripe_customer_id, String, null: true

    def name
      "#{object.first_name} #{object.last_name}"
    end
  end
end
