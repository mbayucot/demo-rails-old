module Mutations
  class DestroyComment < BaseMutation
    def ready?(**_args)
      if !context[:current_user]
        raise GraphQL::ExecutionError, "You need to login!"
      else
        true
      end
    end

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
