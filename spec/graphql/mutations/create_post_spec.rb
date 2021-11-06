require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe Mutations::CreatePost, type: :graphql do
  let(:user) { create(:user) }

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

  it 'is successful' do
    post = create(:post, title: "My Cool Thoughts")
    context = {
      # Query context goes here, for example:
      current_user: user,
    }
    post_id = RailsDockerStarterKitSchema.id_from_object(post, Types::PostType, {})
    result = RailsDockerStarterKitSchema.execute(mutation, variables: { title: "My Cool Thoughts", body: 'body', tagList: ['tag'] }, context: context)

    post_result = result["data"]["createPost"]["post"]

    # Make sure the query worked
    #expect(post_result["id"]).to eq(post_id)
    expect(post_result["title"]).to eq("My Cool Thoughts")
  end
end