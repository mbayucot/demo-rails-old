require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe Mutations::UpdateUser, type: :request do
  let(:user) { create(:user) }
  let(:valid_attributes) { { email: Faker::Internet.email } }
  let(:invalid_attributes) { { email: nil } }

  let(:valid_headers) do
    Devise::JWT::TestHelpers.auth_headers({ Accept: 'application/json' }, user)
  end

  let(:mutation) do
    <<~GQL
      mutation($id: ID!, $attributes: UserAttributes!) {
        updateUser(id: $id, attributes: $attributes) {
          user {
            id
            email
          }
          errors {
            path
            message
          }
        }
      }
    GQL
  end

  context 'with valid parameters' do
    it 'updates the requested User' do
      post graphql_url, params: { query: mutation, variables: { id: user.id, attributes: valid_attributes } }, headers: valid_headers
      user.reload
      expect(user.email).to eq(valid_attributes[:email])
    end

    it 'returns a User' do
      post graphql_url, params: { query: mutation, variables: { id: user.id, attributes: valid_attributes } }, headers: valid_headers
      expect(json['data']['updateUser']['user']).to include_json(email: valid_attributes[:email])
    end
  end

  context 'with invalid parameters' do
    it 'returns an error message', :aggregate_failures do
      post graphql_url, params: { query: mutation, variables: { id: user.id, attributes: invalid_attributes } }, headers: valid_headers
      p json
      expect(json['data']['updateUser']['errors']).to include_json([{"path"=>["attributes", "email"], "message"=>"Email can't be blank"}])
    end
  end
end