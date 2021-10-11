module Mutations
  class DestroyUser < BaseMutation
    def ready?(**_args)
      if !context[:current_user]
        raise GraphQL::ExecutionError, "You need to login!"
      else
        true
      end
    end

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
