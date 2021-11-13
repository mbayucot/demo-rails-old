module Mutations
  class CreatePost < BaseMutation
    #def ready?(**_args)
    #  if !context[:current_user]
    #    raise GraphQL::ExecutionError, "You need to login!"
    #  else
    #    true
    #  end
    #end

    field :post, Types::PostType, null: true
    field :errors, [Types::UserErrorType], null: true

    argument :title, String, required: false
    argument :body, String, required: false
    argument :tagList, [String], required: false

    def resolve(title: nil, body: nil, tagList: nil)
      post = context[:current_user].posts.new(title: title, body: body, tag_list: tagList)
      Pundit.authorize context[:current_user], post, :create?
      post.save!
      {
        post: post,
      }
    end
  end
end
