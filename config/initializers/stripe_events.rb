StripeEvent.signing_secret = ENV['STRIPE_SIGNING_SECRET']

StripeEvent.configure do |events|
  events.subscribe 'customer.subscription.updated' do |event|
    StripeInteractors::UpdateSubscription.call(stripe_sub: event.data.object)
  end
end
