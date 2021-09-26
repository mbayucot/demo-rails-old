module Mutations
  class UpdateComment < BaseMutation
    field :comment, Types::CommentType, null: false

    argument :body, String, required: true
    argument :attributes, Types::CommentAttributes, required: true

    def resolve(id:, attributes:)
      comment = Comment.find(id)
      if comment.update(attributes.to_h)
        { comment: comment }
      else
        raise GraphQL::ExecutionError, comment.errors.full_messages.join(", ")
      end
    end
  end
end
