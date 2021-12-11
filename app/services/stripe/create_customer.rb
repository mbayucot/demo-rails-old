module Stripe
  class CreateCustomer
    def initialize(user_id)
      @user_id = user_id
    end

    def call
      user = User.find(@user_id)
      result = Stripe::Customer.create(
        email: user.email,
        name: "#{user.first_name} #{user.last_name}"
      )
      user.update!(stripe_customer_id: result.id)
    end
  end
end
