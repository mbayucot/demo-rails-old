require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe Mutations::CreatePost, type: :request do
  let(:user) { create(:user) }
  let(:valid_attributes) { { title: Faker::Lorem.word, body: Faker::Lorem.word, tagList: [Faker::Lorem.word] } }
  let(:invalid_attributes) { { title: nil } }

  let(:valid_headers) do
    Devise::JWT::TestHelpers.auth_headers({ Accept: 'application/json' }, user)
  end

  let(:mutation) do
    <<~GQL
      mutation($title: String, $body: String, $tagList: [String!]) {
        createPost(title: $title, body: $body, tagList: $tagList) {
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
    it 'creates a new Post' do
      expect do
        post graphql_url, params: { query: mutation, variables: valid_attributes }, headers: valid_headers
      end.to change(Post, :count).by(1)
    end

    it 'returns a Post' do
      post graphql_url, params: { query: mutation, variables: valid_attributes }, headers: valid_headers
      expect(json['data']['createPost']['post']).to include_json(title: valid_attributes[:title])
    end
  end

  context 'with invalid parameters' do
    it 'does not create a new Post' do
      expect do
        post graphql_url, params: { query: mutation, variables: invalid_attributes }, headers: valid_headers
      end.to change(Post, :count).by(0)
    end

    it 'returns an error message', :aggregate_failures do
      post graphql_url, params: { query: mutation, variables: invalid_attributes }, headers: valid_headers
      expect(json['errors'].first['extensions']).to include_json("title"=>["Title can't be blank"])
    end
  end
end