module Mutations
  class UpdatePost < BaseMutation
    def ready?(**_args)
      if !context[:current_user]
        raise GraphQL::ExecutionError, "You need to login!"
      else
        true
      end
    end

    field :post, Types::PostType, null: false

    argument :id, ID, required: true
    argument :attributes, Types::PostAttributes, required: true

    def resolve(id:, attributes:)
      post = Post.find(id)
      Pundit.authorize context[:current_user], post, :update?
      if post.update(attributes.to_h)
        { post: post }
      else
        raise GraphQL::ExecutionError, Post.errors.full_messages.join(", ")
      end
    end
  end
end
