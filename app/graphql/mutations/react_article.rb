module Mutations
  class ReactArticle < BaseMutation
    def ready?(**_args)
      if !context[:current_user]
        raise GraphQL::ExecutionError, "You need to login!"
      else
        true
      end
    end

    field :article, Types::ArticleType, null: false

    argument :id, ID, required: true
    argument :weight, Int, required: true

    def resolve(id:, weight:)
      article = Article.find(id)
      article.liked_by context[:current_user], vote_weight: weight
      { article: article }
    end
  end
end
