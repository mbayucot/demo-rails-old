module Types
  class ArticleAttributes < Types::BaseInputObject
    description "Attributes for creating or updating a blog article"
    argument :title, String, "Header for the article", required: true
    argument :body, String, "Full body of the article", required: true
  end
end
