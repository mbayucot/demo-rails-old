module Mutations
  class DestroyPost < BaseMutation
    field :post, Types::PostType, null: false

    argument :id, ID, required: true

    def resolve(id:)
      post = Post.find(id)
      Pundit.authorize context[:current_user], post, :destroy?
      post.destroy
      {
        post: post,
      }
    end
  end
end
