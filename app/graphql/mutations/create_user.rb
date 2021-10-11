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
    field :errors, [Types::UserErrorType], null: false

    argument :email, String, required: true
    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :password, String, required: true

    def resolve(email:, first_name:, last_name:, password:)
      user = User.new(email: email, first_name: first_name, last_name: last_name, password: password)
      if user.save
        {
          user: user,
          errors: [],
        }
      else
        user_errors = user.errors.map do |attribute, message|
          path = ["attributes", attribute.to_s.camelize(:lower)]
          {
            path: path,
            message: message,
          }
        end
        {
          user: user,
          errors: user_errors
        }
      end
    end
  end
end
