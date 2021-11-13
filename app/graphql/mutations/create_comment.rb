module Mutations
  class CreateComment < BaseMutation
    field :comment, Types::CommentType, null: true
    field :errors, [Types::UserErrorType], null: true

    argument :post_id, ID, required: false
    argument :body, String, required: false
    argument :parent_id, ID, required: false

    def resolve(post_id:, body:, parent_id: nil)
      post = Post.find(post_id)
      #comment = post.comments.new(body: body, parent_id: parent_id)
      comment = post.comments.new(body: body)
      comment.user = context[:current_user]
      if comment.save
        {
          comment: comment
        }
      else
        {
          errors: pretty_errors(comment.errors)
        }
      end
    end
  end
end
