module Mutations
  class DestroyUser < BaseMutation
    field :user, Types::UserType, null: false

    argument :id, ID, required: true

    def resolve(id:)
      user = User.find(id)
      user.destroy
      {
        user: user,
      }
    end
  end
end
