module Types
  class PostType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: true
    field :body, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :slug, String, null: true
    field :body, String, null: true
    field :tags, [TagType], null: true
    field :tag_list, [String], null: true
    field :user, Types::UserType, null: true
    field :comments, [Types::CommentType], null: true
  end
end
