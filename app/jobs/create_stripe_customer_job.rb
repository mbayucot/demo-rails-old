class CreateStripeCustomerJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    Stripe::CreateCustomer.new(user_id).call
  end
end
