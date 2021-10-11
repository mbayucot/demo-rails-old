module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :articles, Types::ArticleType.collection_type, null: true do
      argument :page, Integer, required: false
      argument :query, String, required: false
      argument :sort, String, required: false
    end

    field :article, ArticleType, null: false do
      argument :id, ID, required: true, as: :id
    end

    field :users, Types::UserType.collection_type, null: true do
      argument :page, Integer, required: false
      argument :query, String, required: false
    end

    field :user, UserType, null: false do
      argument :id, ID, required: true, as: :id
    end

    def article(id:)
      Article.find(id)
    end

    def user(id:)
      User.find(id)
    end

    def articles(page: nil, query: nil, sort: nil)
      ::Article.where("title ILIKE ?", "%#{query}%").page(page).order(created_at: sort)
    end

    def users(page: nil, query: nil)
      ::User.where("first_name ILIKE ?", "%#{query}%").page(page)
    end
  end
end
