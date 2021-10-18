module Types
  class CommentAttributes < Types::BaseInputObject
    description "Attributes for creating or updating a blog post comment"
    argument :body, String, "Full body of the comment", required: true
  end
end
