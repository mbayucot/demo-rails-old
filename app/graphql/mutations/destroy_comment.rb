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

    argument :id, ID, required: true

    def resolve(id:)
      comment = Comment.find(id)
      Pundit.authorize context[:current_user], comment, :destroy?
      comment.destroy
      {
        comment: comment,
      }
    end
  end
end
