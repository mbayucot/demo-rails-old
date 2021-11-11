require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe Mutations::CreatePost, type: :request do
  let(:user) { create(:user) }
  let!(:posts) { create_list(:post, 10, user_id: user.id) }

  let(:valid_headers) do
    Devise::JWT::TestHelpers.auth_headers({ Accept: 'application/json' }, user)
  end

  let(:mutation) do
    <<~GQL
      query($page: Int, $query: String) {
        posts(page: $page, query: $query) {
          collection {
            id
            title
            body
            slug
            updatedAt
            tagList
            user {
              id
              firstName
              lastName
            }
          }
          metadata {
            totalPages
            totalCount
            currentPage
            limitValue
          }
        }
      }
    GQL
  end

  context 'with no parameter' do
    it 'returns a paginated result' do
      post graphql_url, params: { query: mutation }, headers: valid_headers
      expect(json['data']['posts']['collection'].size).to eq(10)
    end

    it 'returns a pagination metadata' do
      post graphql_url, params: { query: mutation }, headers: valid_headers
      expect(json['data']['posts']['metadata']).to include_json({"totalPages"=>1, "totalCount"=>10, "currentPage"=>1, "limitValue"=>25})
    end
  end
end