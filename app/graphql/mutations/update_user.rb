module Mutations
  class UpdateUser < BaseMutation
    field :user, Types::UserType, null: false
    field :errors, [Types::UserErrorType], null: true

    argument :id, ID, required: false
    argument :attributes, Types::UserAttributes, required: true

    def resolve(id: nil, attributes:)
      user = id.present? ? context[:current_user] : User.find(id)
      Pundit.authorize context[:current_user], user, :update?
      user.update!(attributes.to_h)
      { user: user }
    end
  end
end
