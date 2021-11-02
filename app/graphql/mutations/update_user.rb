module Mutations
  class UpdateUser < BaseMutation
    def ready?(**_args)
      if !context[:current_user]
        raise GraphQL::ExecutionError, "You need to login!"
      else
        true
      end
    end

    field :user, Types::UserType, null: false

    argument :id, ID, required: false
    argument :attributes, Types::UserAttributes, required: true

    def resolve(id: nil, attributes:)
      user = id.present? ? context[:current_user] : User.find(id)
      Pundit.authorize context[:current_user], user, :update?
      if user.update(attributes.to_h)
        { user: user }
      else
        raise GraphQL::ExecutionError, user.errors.full_messages.join(", ")
      end
    end
  end
end
