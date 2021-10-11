module Mutations
  class CreateArticle < BaseMutation
    def ready?(**_args)
      if !context[:current_user]
        raise GraphQL::ExecutionError, "You need to login!"
      else
        true
      end
    end

    field :article, Types::ArticleType, null: false
    field :errors, [Types::UserErrorType], null: false

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
        user_errors = article.errors.map do |attribute, message|
          path = ["attributes", attribute.to_s.camelize(:lower)]
          {
            path: path,
            message: message,
          }
        end
        {
          article: article,
          errors: user_errors
        }
      end
    end
  end
end
