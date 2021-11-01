module Mutations
  class DestroyPost < BaseMutation
    def ready?(**_args)
      if !context[:current_user]
        raise GraphQL::ExecutionError, "You need to login!"
      else
        true
      end
    end

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
