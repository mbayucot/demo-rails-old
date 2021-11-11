require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe Mutations::DestroyUser, type: :request do
  let(:user) { create(:user) }
  let!(:users) { create_list(:user, 5) }
  let(:record) { users.first }

  let(:valid_headers) do
    Devise::JWT::TestHelpers.auth_headers({ Accept: 'application/json' }, user)
  end

  let(:mutation) do
    <<~GQL
      mutation($id: ID!) {
        destroyUser(id: $id) {
          user {
            id
            email
          }
        }
      }
    GQL
  end

  it 'destroys the requested user' do
    expect do
      post graphql_url, params: { query: mutation, variables: { id: record.id } }, headers: valid_headers
      p json
    end.to change(User, :count).by(-1)
  end
end