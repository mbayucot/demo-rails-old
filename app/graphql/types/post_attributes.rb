module Types
  class PostAttributes < Types::BaseInputObject
    description "Attributes for creating or updating a blog post"
    argument :title, String, "Header for the post", required: false
    argument :body, String, "Full body of the post", required: false
    argument :tag_list, [String], "Tags of post", required: false
  end
end
