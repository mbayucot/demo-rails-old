module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :articles, Types::ArticleType.collection_type, null: true do
      argument :page, Integer, required: false
      argument :limit, Integer, required: false
    end

    field :users, Types::UserType.collection_type, null: true do
      argument :page, Integer, required: false
      argument :limit, Integer, required: false
    end

    field :user, UserType, null: false do
      argument :id, ID, required: true, as: :id
    end

    def user(id:)
      User.find(id)
    end

    def articles(page: nil, limit: nil)
      ::Article.page(page).per(limit)
    end

    def users(page: nil, limit: nil)
      ::User.page(page).per(limit)
    end
  end
end
