require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe Mutations::CreatePost, type: :request do
  let(:record) { create(:user) }

  let(:valid_headers) do
    Devise::JWT::TestHelpers.auth_headers({ Accept: 'application/json' }, record)
  end

  let(:mutation) do
    <<~GQL
      query($id: ID!) {
        user(id: $id) {
          id
          email
          firstName
          lastName
        }
      }
    GQL
  end

  context 'with valid parameters' do
    it 'returns a user' do
      post graphql_url, params: { query: mutation, variables: { id: record.id} }, headers: valid_headers
      expect(json['data']['user']).to include_json({"email" => record.email})
    end
  end

  context 'with invalid parameters' do
    it 'returns 404' do
      post graphql_url, params: { query: mutation, variables: { id: 0} }, headers: valid_headers
    end
  end
end