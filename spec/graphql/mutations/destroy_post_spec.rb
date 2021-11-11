require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe Mutations::DestroyPost, type: :request do
  let(:user) { create(:user) }
  let!(:posts) { create_list(:post, 5) }
  let(:record) { posts.first }

  let(:valid_headers) do
    Devise::JWT::TestHelpers.auth_headers({ Accept: 'application/json' }, user)
  end

  let(:mutation) do
    <<~GQL
      mutation($id: ID!) {
        destroyPost(id: $id) {
          post {
            id
            title
          }
        }
      }
    GQL
  end

  it 'destroys the requested post' do
    expect do
      post graphql_url, params: { query: mutation, variables: { id: record.id } }, headers: valid_headers
    end.to change(Post, :count).by(-1)
  end
end