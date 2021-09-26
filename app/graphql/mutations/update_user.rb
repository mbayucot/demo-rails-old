module Mutations
  class UpdateUser < BaseMutation
    field :user, Types::UserType, null: false

    argument :id, ID, required: true
    argument :attributes, Types::ArticleAttributes, required: true

    def resolve(id:, attributes:)
      user = User.find(id)
      if user.update(attributes.to_h)
        { user: user }
      else
        raise GraphQL::ExecutionError, user.errors.full_messages.join(", ")
      end
    end
  end
end
