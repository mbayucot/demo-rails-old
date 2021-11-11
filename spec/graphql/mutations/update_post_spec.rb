require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe Mutations::UpdatePost, type: :request do
  let(:user) { create(:user) }
  let(:record) { create(:post) }
  let(:valid_attributes) { { title: Faker::Lorem.word } }
  let(:invalid_attributes) { { title: nil, body: nil } }

  let(:valid_headers) do
    Devise::JWT::TestHelpers.auth_headers({ Accept: 'application/json' }, user)
  end

  let(:mutation) do
    <<~GQL
      mutation($id: ID!, $attributes: PostAttributes!) {
        updatePost(id: $id, attributes: $attributes) {
          post {
            id
            title
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
    it 'updates the requested Post' do
      post graphql_url, params: { query: mutation, variables: { id: record.id, attributes: valid_attributes } }, headers: valid_headers
      record.reload
      expect(record.title).to eq(valid_attributes[:title])
    end

    it 'returns a Post' do
      post graphql_url, params: { query: mutation, variables: { id: record.id, attributes: valid_attributes } }, headers: valid_headers
      expect(json['data']['updatePost']['post']).to include_json(title: valid_attributes[:title])
    end
  end

  context 'with invalid parameters' do
    it 'returns an error message', :aggregate_failures do
      post graphql_url, params: { query: mutation, variables: { id: record.id, attributes: invalid_attributes } }, headers: valid_headers
      expect(json['data']['updatePost']['errors']).to include_json([{"path"=>["attributes", "title"], "message"=>"Title can't be blank"}])
    end
  end
end