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
    field :errors, [Types::UserErrorType], null: true

    argument :body, String, required: true
    argument :attributes, Types::CommentAttributes, required: true

    def resolve(id:, attributes:)
      comment = Comment.find(id)
      Pundit.authorize context[:current_user], comment, :update?
      if comment.update(attributes.to_h)
        { comment: comment }
      else
        {
          user: user,
          errors: pretty_errors(comment.errors)
        }
      end
    end
  end
end
