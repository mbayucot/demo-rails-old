require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe Mutations::CreatePost, type: :graphql do
  let(:user) { create(:user) }

  let!(:projects) { create_list(:project, 15, created_by: user.id) }
  let(:project) { projects.first }

  let(:mutation) do
    <<~GQL
      mutation($input: LoginInput!) {
        login(input: $input) {
          success
        }
      }
    GQL
  end

  it 'is successful' do
    user = create(:user)

    result = execute_graphql(
      mutation,
      variables: { input: { email: user.email, password: 'password' } },
      )

    aggregate_failures do
      expect(controller.current_user).to eq user
      expect(result['data']['login']['success']).to eq true
    end
  end

  it 'fails' do
    result = execute_graphql(
      mutation,
      variables: { input: { email: 'whatever', password: 'whatever' } },
      )

    expect(result['data']['login']['success']).to eq false
  end
end