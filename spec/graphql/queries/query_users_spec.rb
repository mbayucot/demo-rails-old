require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe "QueryUser", type: :request do
  let!(:users) { create_list(:user, 10) }
  let(:record) { users.first }

  let(:valid_headers) do
    Devise::JWT::TestHelpers.auth_headers({ Accept: 'application/json' }, record)
  end

  let(:mutation) do
    <<~GQL
      query($page: Int, $query: String) {
        users(page: $page, query: $query) {
          collection {
            id
            email
            name
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
      expect(json['data']['users']['collection'].size).to eq(10)
    end

    it 'returns a pagination metadata' do
      post graphql_url, params: { query: mutation }, headers: valid_headers
      p json
      expect(json['data']['users']['metadata']).to include_json({"totalPages"=>1, "totalCount"=>10, "currentPage"=>1, "limitValue"=>25})
    end
  end
end