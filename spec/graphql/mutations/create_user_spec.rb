require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe Mutations::CreateUser, type: :request do
  let!(:user) { create(:user) }
  let(:valid_attributes) { { email: Faker::Internet.email,
                             password: 'pass1234',
                             firstName: Faker::Name.first_name,
                             lastName: Faker::Name.last_name } }
  let(:invalid_attributes) { { email: Faker::Name.first_name, password: nil } }

  let(:valid_headers) do
    Devise::JWT::TestHelpers.auth_headers({ Accept: 'application/json' }, user)
  end

  let(:mutation) do
    <<~GQL
      mutation($email: String, $firstName: String, $lastName: String, $password: String) {
        createUser(email: $email, firstName: $firstName, lastName: $lastName, password: $password) {
          user {
            id
            email
          }
        }
      }
    GQL
  end

  context 'with valid parameters' do
    it 'creates a new User' do
      expect do
        post graphql_url, params: { query: mutation, variables: valid_attributes }, headers: valid_headers
      end.to change(User, :count).by(1)
    end

    it 'returns a User' do
      post graphql_url, params: { query: mutation, variables: valid_attributes }, headers: valid_headers
      expect(json['data']['createUser']['user']).to include_json(email: valid_attributes[:email])
    end
  end

  context 'with invalid parameters' do
    it 'does not create a new User' do
      expect do
        post graphql_url, params: { query: mutation, variables: invalid_attributes }, headers: valid_headers
      end.to change(User, :count).by(0)
    end

    it 'returns an error message', :aggregate_failures do
      post graphql_url, params: { query: mutation, variables: invalid_attributes }, headers: valid_headers
      expect(json).to include_json('errors': [{message: "Variable $firstName of type String! was provided invalid value"}])
    end
  end
end