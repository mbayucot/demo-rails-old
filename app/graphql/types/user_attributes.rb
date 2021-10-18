module Types
  class UserAttributes < Types::BaseInputObject
    description "Attributes for creating or updating a blog post comment"
    argument :email, String, "Full body of the comment", required: false
    argument :first_name, String, "Full body of the comment", required: false
    argument :last_name, String, "Full body of the comment", required: false
    #argument :role, String, "Full body of the comment", required: false
  end
end
