module Types
  class PostType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :body, String, null: false
    #field :created_at, GraphQL::Types::ISO8601DateTime, null: true
    #field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
    field :created_at, String, null: true
    field :updated_at, String, null: true
    field :slug, String, null: true
    field :tags, [TagType], null: true
    field :tag_list, [String], null: true
    field :user, Types::UserType, null: true
    field :comments, [Types::CommentType], null: true
  end
end
