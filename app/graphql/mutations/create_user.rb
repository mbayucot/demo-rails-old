module Mutations
  class CreateUser < BaseMutation
    field :user, Types::UserType, null: true
    field :errors, [Types::UserErrorType], null: true

    argument :email, String, required: false
    argument :first_name, String, required: false
    argument :last_name, String, required: false
    argument :password, String, required: false

    def resolve(email: nil, first_name: nil, last_name: nil, password: nil)
      user = User.new(email: email, first_name: first_name, last_name: last_name, password: password)
      Pundit.authorize context[:current_user], user, :create?
      if user.save
        {
          user: user,
        }
      else
        {
          errors: pretty_errors(user.errors)
        }
      end
    end
  end
end
