require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe Mutations::CreateComment, type: :request do
  let(:user) { create(:user) }
  let(:record) { create(:post) }

  let(:valid_attributes) { { postId: record.id, body: Faker::Lorem.sentence } }
  let(:invalid_attributes) { { postId: nil, body: nil } }

  let(:valid_headers) do
    Devise::JWT::TestHelpers.auth_headers({ Accept: 'application/json' }, user)
  end

  let(:mutation) do
    <<~GQL
      mutation($postId: ID!, $body: String!, $parentId: ID) {
        createComment(postId: $postId, body: $body, parentId: $parentId) {
          comment {
            id
            body
            ancestry
            children {
              id
              body
              ancestry
            }
          }
        }
      }
    GQL
  end

  context 'with valid parameters' do
    it 'creates a new Comment' do
      expect do
        post graphql_url, params: { query: mutation, variables: valid_attributes }, headers: valid_headers
      end.to change(Comment, :count).by(1)
    end

    it 'returns a Comment' do
      post graphql_url, params: { query: mutation, variables: valid_attributes }, headers: valid_headers
      expect(json['data']['createComment']['comment']).to include_json(body: valid_attributes[:body])
    end
  end

  context 'with invalid parameters' do
    it 'does not create a new Comment' do
      expect do
        post graphql_url, params: { query: mutation, variables: invalid_attributes }, headers: valid_headers
      end.to change(Comment, :count).by(0)
    end

    it 'returns an error message', :aggregate_failures do
      post graphql_url, params: { query: mutation, variables: invalid_attributes }, headers: valid_headers
      expect(json).to include_json('errors': [{message: "Variable $postId of type ID! was provided invalid value"}])
    end
  end
end