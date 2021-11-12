module Mutations
  class DestroyUser < BaseMutation
    field :user, Types::UserType, null: false

    argument :id, ID, required: true

    def resolve(id:)
      user = User.find(id)
      Pundit.authorize context[:current_user], user, :destroy?
      user.destroy
      {
        user: user,
      }
    end
  end
end
