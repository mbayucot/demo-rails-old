module Types
  class CommentType < Types::BaseObject
    field :id, ID, null: false
    field :body, String, null: false
    field :post_id, Integer, null: false
    field :parent_id, ID, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: true
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
    field :ancestry, String, null: true
    field :children, [Types::CommentType], null: true
    field :user, Types::UserType, null: true
  end
end
