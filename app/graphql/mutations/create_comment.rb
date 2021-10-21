module Mutations
  class CreateComment < BaseMutation
    def ready?(**_args)
      if !context[:current_user]
        raise GraphQL::ExecutionError, "You need to login!"
      else
        true
      end
    end

    field :comment, Types::CommentType, null: false
    field :errors, [Types::UserErrorType], null: false

    argument :post_id, ID, required: true
    argument :body, String, required: true
    argument :parent_id, ID, required: false

    def resolve(post_id:, body:, parent_id:)
      post = Post.find(post_id)
      comment = post.comments.new(body: body, parent_id: parent_id)
      comment.user = context[:current_user]
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
