module Mutations
  class DestroyArticle < BaseMutation
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
