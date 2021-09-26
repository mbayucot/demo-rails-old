module Mutations
  class CreateComment < BaseMutation
    field :comment, Types::CommentType, null: false
    field :errors, [Types::UserError], null: false

    argument :article_id, ID, required: true
    argument :body, String, required: true

    def resolve(article_id:, body:)
      article = Article.find(article_id)

      comment = context[:current_user].comments.new(article: article, body: body)
      if comment.save
        {
          comment: comment,
          errors: [],
        }
      else
        user_errors = comment.errors.map do |attribute, message|
          path = ["attributes", attribute.to_s.camelize(:lower)]
          {
            path: path,
            message: message,
          }
        end

        {
          comment: comment,
          errors: user_errors
        }
      end
    end
  end
end
