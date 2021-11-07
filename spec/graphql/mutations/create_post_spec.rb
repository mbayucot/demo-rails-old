require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe Mutations::CreatePost, type: :graphql do
  let(:user) { create(:user) }
  let(:context) { { current_user: user } }
  let(:post) { create(:post, title: "My Cool Thoughts") }
  let(:valid_attributes) { { title: "My Cool Thoughts", body: 'body', tagList: ['tag'] } }
  let(:invalid_attributes) { { title: nil, body: nil, tagList: nil } }

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

  context 'with valid parameters' do
    it 'creates a new Post' do
      expect do
        RailsDockerStarterKitSchema.execute(mutation, variables: valid_attributes, context: context)
      end.to change(Post, :count).by(1)
    end

    it 'returns the created Post' do
      result = RailsDockerStarterKitSchema.execute(mutation, variables: valid_attributes, context: context)
      post_result = result["data"]["createPost"]["post"]
      expect(post_result["title"]).to eq(post["title"])
    end
  end

  context 'with invalid parameters' do
    it 'does not create a new Post' do
      expect do
        RailsDockerStarterKitSchema.execute(mutation, variables: invalid_attributes, context: context)
      end.to change(Post, :count).by(0)
    end

    it 'returns an error message', :aggregate_failures do
      result = RailsDockerStarterKitSchema.execute(mutation, variables: invalid_attributes, context: context)
      expect(result["errors"].first["message"]).to eq("Variable $title of type String! was provided invalid value")
    end
  end
end