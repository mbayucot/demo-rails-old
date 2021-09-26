module Mutations
  class DestroyComment < BaseMutation
    field :comment, Types::CommentType, null: false

    # TODO: define arguments
    argument :id, ID, required: true

    def resolve(id:)
      comment = Comment.find(id)
      comment.destroy
      {
        comment: comment,
      }
    end
  end
end
