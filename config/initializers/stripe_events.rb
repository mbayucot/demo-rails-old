StripeEvent.signing_secret = ENV['STRIPE_SIGNING_SECRET']

StripeEvent.configure do |events|
  events.subscribe 'customer.subscription.created' do |event|
    StripeInteractors::CreateSubscription.call(subscription: event.data.object)
  end

  events.subscribe 'customer.subscription.updated' do |event|
    StripeInteractors::UpdateSubscription.call(subscription: event.data.object)
  end
end
