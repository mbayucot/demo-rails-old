module Mutations
  class ReactPost < BaseMutation
    def ready?(**_args)
      if !context[:current_user]
        raise GraphQL::ExecutionError, "You need to login!"
      else
        true
      end
    end

    field :post, Types::PostType, null: false

    argument :id, ID, required: true
    argument :weight, Int, required: true

    def resolve(id:, weight:)
      post = Post.find(id)
      post.liked_by context[:current_user], vote_weight: weight
      #Post.unliked_by current_user
      { post: post }
    end
  end
end
