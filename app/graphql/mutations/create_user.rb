module Mutations
  class CreateUser < BaseMutation
    def ready?(**_args)
      if !context[:current_user]
        raise GraphQL::ExecutionError, "You need to login!"
      else
        true
      end
    end

    field :user, Types::UserType, null: false
    field :errors, [Types::UserErrorType], null: true

    argument :email, String, required: true
    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :password, String, required: true

    def resolve(email:, first_name:, last_name:, password:)
      user = User.new(email: email, first_name: first_name, last_name: last_name, password: password)
      Pundit.authorize context[:current_user], user, :create?
      if user.save
        {
          user: user,
          errors: [],
        }
      else
        {
          user: user,
          errors: pretty_errors(user.errors)
        }
      end
    end
  end
end
