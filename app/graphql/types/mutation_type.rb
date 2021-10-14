module Types
  class MutationType < Types::BaseObject
    field :react_article, mutation: Mutations::ReactArticle
    field :destroy_user, mutation: Mutations::DestroyUser
    field :update_user, mutation: Mutations::UpdateUser
    field :create_user, mutation: Mutations::CreateUser
    field :destroy_comment, mutation: Mutations::DestroyComment
    field :update_comment, mutation: Mutations::UpdateComment
    field :create_comment, mutation: Mutations::CreateComment
    field :destroy_article, mutation: Mutations::DestroyArticle
    field :update_article, mutation: Mutations::UpdateArticle
    field :create_article, mutation: Mutations::CreateArticle
  end
end
