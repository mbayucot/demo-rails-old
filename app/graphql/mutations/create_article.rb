module Mutations
  class CreateArticle < BaseMutation
    field :article, Types::ArticleType, null: false
    field :errors, [String], null: false

    argument :title, String, required: true
    argument :body, String, required: true

    def resolve(title:, body:)
      article = context[:current_user].articles.new(title: title, body: body)
      if article.save
        {
          article: article,
          errors: [],
        }
      else
        {
          article: nil,
          errors: article.errors.full_messages
        }
      end
    end
  end
end
