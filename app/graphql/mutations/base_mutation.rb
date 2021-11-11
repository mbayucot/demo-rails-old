module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    #argument_class Types::BaseArgument
    #field_class Types::BaseField
    #input_object_class Types::BaseInputObject
    #object_class Types::BaseObject
    null false

    def pretty_errors(errors)
      errors.map do |error|
        path = ["attributes", error.attribute.to_s.camelize(:lower)]
        {
          path: path,
          message: error.full_message,
        }
      end
    end
  end
end
