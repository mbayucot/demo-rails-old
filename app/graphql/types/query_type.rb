module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :posts, Types::PostType.collection_type, null: true do
      argument :page, Integer, required: false
      argument :query, String, required: false
      argument :sort, String, required: false
    end

    field :post, PostType, null: false do
      argument :id, ID, required: true, as: :id
    end

    field :users, Types::UserType.collection_type, null: true do
      argument :page, Integer, required: false
      argument :query, String, required: false
    end

    field :user, UserType, null: false do
      argument :id, ID, required: true, as: :id
    end

    field :tags, [Types::TagType], null: true do
      argument :query, String, required: false
    end

    def post(id:)
      Post.find(id)
    end

    def user(id:)
      User.find(id)
    end

    def posts(page: nil, query: nil, sort: 'asc')
      ::Post.where("title ILIKE ?", "%#{query}%").page(page).order(created_at: sort)
    end

    def users(page: nil, query: nil)
      ::User.where("first_name ILIKE ?", "%#{query}%").page(page)
    end

    def tags(query: nil)
      ::Post.tagged_with(query, wild: true, any: true)
    end
  end
end
