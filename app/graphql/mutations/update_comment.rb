module Mutations
  class UpdateComment < BaseMutation
    def ready?(**_args)
      if !context[:current_user]
        raise GraphQL::ExecutionError, "You need to login!"
      else
        true
      end
    end

    field :comment, Types::CommentType, null: false

    argument :body, String, required: true
    argument :attributes, Types::CommentAttributes, required: true

    def resolve(id:, attributes:)
      comment = Comment.find(id)
      Pundit.authorize context[:current_user], comment, :update?
      if comment.update(attributes.to_h)
        { comment: comment }
      else
        raise GraphQL::ExecutionError, comment.errors.full_messages.join(", ")
      end
    end
  end
end
