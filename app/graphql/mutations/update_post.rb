module Mutations
  class UpdatePost < BaseMutation
    field :post, Types::PostType, null: false
    field :errors, [Types::UserErrorType], null: true

    argument :id, ID, required: true
    argument :attributes, Types::PostAttributes, required: true

    def resolve(id:, attributes:)
      post = Post.find(id)
      Pundit.authorize context[:current_user], post, :update?
      post.update!(attributes.to_h)
      { post: post }
    end
  end
end
