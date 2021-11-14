require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe Mutations::ReactPost, type: :request do
  let(:user) { create(:user) }
  let(:record) { create(:post) }
  let(:valid_attributes) { { id: record.id, weight: 1 } }
  let(:invalid_attributes) { { id: record.id, weight: nil } }

  let(:valid_headers) do
    Devise::JWT::TestHelpers.auth_headers({ Accept: 'application/json' }, user)
  end

  # FIXME: Id
  let(:mutation) do
    <<~GQL
      mutation($id: ID!, $weight: ID!) {
        reactPost(id: $id, weight: $weight) {
          post {
            id
            title
          }
        }
      }
    GQL
  end

  context 'with valid parameters' do
    it 'reacts a Post' do
      expect do
        post graphql_url, params: { query: mutation, variables: valid_attributes }, headers: valid_headers
        record.reload
      end.to change{ record.votes_for.size }.by(1)
    end

    it 'returns a Post' do
      post graphql_url, params: { query: mutation, variables: valid_attributes }, headers: valid_headers
      expect(json['data']['reactPost']['post']).to include_json(title: record.title)
    end
  end

  context 'with invalid parameters' do
    it 'does not react a Post' do
      expect do
        post graphql_url, params: { query: mutation, variables: invalid_attributes }, headers: valid_headers
        record.reload
      end.to change{ record.votes_for.size }.by(0)
    end
  end
end