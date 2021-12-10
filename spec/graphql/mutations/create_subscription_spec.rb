require 'rails_helper'
require 'devise/jwt/test_helpers'
require 'stripe_mock'

RSpec.describe Mutations::CreateSubscription, type: :request do
  let(:user) { create(:user, stripe_customer_id: 'cust_SLV1') }
  let(:stripe_helper) { StripeMock.create_test_helper }
  let(:valid_attributes) { { token: stripe_helper.generate_card_token } }
  let(:invalid_attributes) { { token: "invalid" } }

  let(:valid_headers) do
    Devise::JWT::TestHelpers.auth_headers({ Accept: 'application/json' }, user)
  end

  before(:all) do
    Stripe.api_key = 'apikey'
    StripeMock.start
  end
  after(:all) { StripeMock.stop }

  let(:mutation) do
    <<~GQL
      mutation($token: String!) {
        createSubscription(token: $token) {
          subscription {
            id
          }
        }
      }
    GQL
  end

  context 'with valid parameters' do
    it 'creates a new Subscription' do
      product = stripe_helper.create_product({id: "prod_CCC", name: "My Product", type: "service"})
      stripe_helper.create_plan(:id => 'my_plan', :amount => 1500, :product => product.id)
      Stripe::Customer.create(id: 'cust_SLV1', source: valid_attributes[:token], :plan => 'my_plan')

      expect do
        post graphql_url, params: { query: mutation, variables: valid_attributes }, headers: valid_headers
      end.to change(Subscription, :count).by(1)
    end

    it 'returns a Subscription' do
      post graphql_url, params: { query: mutation, variables: valid_attributes }, headers: valid_headers
      expect(json['data']['createSubscription']['subscription']).not_to be_nil
    end
  end

  context 'with invalid parameters' do
    it 'does not create a new Subscription' do
      expect do
        post graphql_url, params: { query: mutation, variables: invalid_attributes }, headers: valid_headers
      end.to change(Subscription, :count).by(0)
    end

    it 'returns an error message', :aggregate_failures do
      post graphql_url, params: { query: mutation, variables: invalid_attributes }, headers: valid_headers
     expect(json['errors'].first['extensions']).to include_json("error"=>"Invalid token id: id")
    end
  end
end