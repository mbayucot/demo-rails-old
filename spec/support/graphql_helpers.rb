module Requests
  module GraphqlHelpers
    def graphql_url
      '/graphql'
    end

    # This method launch the graphql request with the `query` and `variables` variables
    # by default. It's convenient when you don't have anything really complicated to test.
    # And when you need to test multiple requests, you can call it with arguments.
    # AccessToken is also generated in here rather than in specs files like I did for a long time
    def do_graphql_request(variables, headers)
      # create is a FactoryBot method
      put '/graphql', params: {
        query: query,
        variables: variables
      }, headers: headers
    end

    # by default, variables is empty indeed
    def variables
      {}
    end

    # I managed to format every errors on my API with the same type
    # so I can use shared_examples for some common test cases
    RSpec.shared_examples 'unauthorized user' do
      it 'return unauthorized error message' do
        expect(errors.pluck('key')).to include('unauthorized')
      end
    end

    # some querys or mutation might be accessible by unauthenticated visitors
    # like registration for example. I need to handle this case.
    def current_user
      nil
    end

    # All my mutations are returning the same payload:
    #
    # field :object, Types::ObjectType, null: true
    # field :errors, [Types::MutationErrorType], null: true
    #
    # and MutationErrorType is defined as follows
    #
    # class Types::MutationErrorType < Types::BaseObject
    #   field :key, String, null: true
    #   field :message, String, null: true
    # end
    def mutation_errors
      json.dig('data', described_class.graphql_name.camelize(:lower), 'errors')
    end
  end
end