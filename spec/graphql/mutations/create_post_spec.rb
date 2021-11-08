require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe Mutations::CreatePost, type: :request do
  let(:user) { create(:user) }
  let(:record) { create(:record, title: "My Cool Thoughts") }
  let(:valid_attributes) { { title: "My Cool Thoughts", body: 'body', tagList: ['tag'] } }
  let(:invalid_attributes) { { title: nil, body: nil, tagList: nil } }

  let(:valid_headers) do
    Devise::JWT::TestHelpers.auth_headers({ Accept: 'application/json' }, user)
  end

  let(:mutation) do
    <<~GQL
      mutation($title: String!, $body: String!, $tagList: [String!]!) {
        createPost(title: $title, body: $body, tagList: $tagList) {
          post {
            id
            title
          }
        }
      }
    GQL
  end

  def query
    <<~GQL
      mutation($title: String!, $body: String!, $tagList: [String!]!) {
        createPost(title: $title, body: $body, tagList: $tagList) {
          post {
            id
            title
          }
        }
      }
    GQL
  end

  context 'with valid parameters' do
    it 'creates a new Post' do
      expect do
        post '/graphql', params: { query: mutation, variables: valid_attributes }, headers: valid_headers
        #do_graphql_request(query: mutation, variables: valid_attributes, headers: valid_headers)
      end.to change(Post, :count).by(1)
    end

    #it 'returns the created Post' do
    #  result = RailsDockerStarterKitSchema.execute(mutation, variables: valid_attributes, context: context)
    #  post_result = result["data"]["createPost"]["post"]
    #  expect(post_result["title"]).to eq(post["title"])
    #end
  end
end