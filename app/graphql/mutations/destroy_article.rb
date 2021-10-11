module Mutations
  class DestroyArticle < BaseMutation
    def ready?(**_args)
      if !context[:current_user]
        raise GraphQL::ExecutionError, "You need to login!"
      else
        true
      end
    end

    field :article, Types::ArticleType, null: false

    argument :id, ID, required: true

    def resolve(id:)
      article = Article.find(id)
      article.destroy
      {
        article: article,
      }
    end
  end
end
