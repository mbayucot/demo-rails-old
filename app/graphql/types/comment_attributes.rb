module Types
  class CommentAttributes < Types::BaseInputObject
    description "Attributes for creating or updating a blog article comment"
    argument :body, String, "Full body of the comment", required: true
  end
end
