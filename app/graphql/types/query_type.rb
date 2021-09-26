module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :articles, Types::ArticleType.collection_type, null: true do
      argument :page, Integer, required: false
      argument :limit, Integer, required: false
    end

    def articles(page: nil, limit: nil)
      ::Article.page(page).per(limit)
    end
  end
end
