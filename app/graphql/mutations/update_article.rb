module Mutations
  class UpdateArticle < BaseMutation
    field :post, Types::ArticleType, null: false

    argument :id, ID, required: true
    argument :attributes, Types::ArticleAttributes, required: true

    def resolve(id:, attributes:)
      article = Article.find(id)
      # Add logic for authorization
      if article.user != context[:current_user]
        raise GraphQL::ExecutionError, "You are not authorized!"
      end
      if article.update(attributes.to_h)
        { article: article }
      else
        raise GraphQL::ExecutionError, article.errors.full_messages.join(", ")
      end
    end
  end
end
