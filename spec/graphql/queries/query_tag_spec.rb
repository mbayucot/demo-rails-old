require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe "GetTags", type: :request do
  let(:user) { create(:user) }
  let(:tag) { Faker::Lorem.word }
  let!(:record) { create(:post, tag_list: [tag]) }

  let(:valid_headers) do
    Devise::JWT::TestHelpers.auth_headers({ Accept: 'application/json' }, user)
  end

  let(:mutation) do
    <<~GQL
      query($query: String) {
        tags(query: $query) {
          id
          name
        }
      }
    GQL
  end

  context 'with valid parameters' do
    it 'returns a tag' do
      post graphql_url, params: { query: mutation, variables: {} }, headers: valid_headers
      expect(json['data']['tags'].first).to include_json({"name" => tag})
    end
  end
end