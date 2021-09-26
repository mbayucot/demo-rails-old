module Mutations
  class DestroyArticle < BaseMutation
    field :id, ID, null: true

    argument :id, ID, required: true

    def resolve(id:)
      article = Article.find(id)
      article.destroy
      {
        id: id,
      }
    end
  end
end
