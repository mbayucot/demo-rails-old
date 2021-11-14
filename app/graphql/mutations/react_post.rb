module Mutations
  class ReactPost < BaseMutation
    field :post, Types::PostType, null: false

    argument :id, ID, required: true
    argument :weight, ID, required: true

    def resolve(id:, weight:)
      post = Post.find(id)
      post.liked_by context[:current_user], vote_weight: weight
      #Post.unliked_by current_user
      { post: post }
    end
  end
end
