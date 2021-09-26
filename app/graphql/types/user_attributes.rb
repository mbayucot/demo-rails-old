module Types
  class ArticleAttributes < Types::BaseInputObject
    description "Attributes for creating or updating a blog article comment"
    argument :email, String, "Full body of the comment", required: true
    argument :first_name, String, "Full body of the comment", required: true
    argument :last_name, String, "Full body of the comment", required: true
    argument :role, String, "Full body of the comment", required: true
  end
end
