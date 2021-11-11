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
    field :errors, [Types::UserErrorType], null: true

    argument :post_id, ID, required: true
    argument :body, String, required: true
    argument :parent_id, ID, required: false

    def resolve(post_id:, body:, parent_id: nil)
      post = Post.find(post_id)
      #comment = post.comments.new(body: body, parent_id: parent_id)
      comment = post.comments.new(body: body)
      Pundit.authorize context[:current_user], comment, :create?
      comment.user = context[:current_user]
      if comment.save
        {
          comment: comment,
          errors: [],
        }
      else
        {
          comment: comment,
          errors: pretty_errors(comment.errors)
        }
      end
    end
  end
end
