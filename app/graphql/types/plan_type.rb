module Types
  class PlanType < Types::BaseObject
    field :id, ID, null: false
    field :price_id, Integer, null: false
    field :product_id, Integer, null: false
    field :amount, Integer, null: false
  end
end
