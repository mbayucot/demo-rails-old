class CreateStripeCustomerJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    result = Stripe::Customer.create(
      email: user.email,
      name: user.name
    )
    user.update!(stripe_customer_id: result.id)
  end
end
