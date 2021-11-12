module Types
  class MutationType < Types::BaseObject
    field :create_subscription, mutation: Mutations::CreateSubscription
    field :react_post, mutation: Mutations::ReactPost
    field :destroy_user, mutation: Mutations::DestroyUser
    field :update_user, mutation: Mutations::UpdateUser
    field :create_user, mutation: Mutations::CreateUser
    field :create_comment, mutation: Mutations::CreateComment
    field :destroy_post, mutation: Mutations::DestroyPost
    field :update_post, mutation: Mutations::UpdatePost
    field :create_post, mutation: Mutations::CreatePost
  end
end
