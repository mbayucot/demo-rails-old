module Mutations
  class CreatePost < BaseMutation
    def ready?(**_args)
      if !context[:current_user]
        raise GraphQL::ExecutionError, "You need to login!"
      else
        true
      end
    end

    field :post, Types::PostType, null: false
    field :errors, [Types::UserErrorType], null: false

    argument :title, String, required: true
    argument :body, String, required: true
    argument :tagList, [String], required: true

    def resolve(title:, body:, tagList:)
      post = context[:current_user].posts.new(title: title, body: body, tag_list: tagList)
      Pundit.authorize context[:current_user], post, :create?
      if post.save
        {
          post: post,
          errors: [],
        }
      else
        user_errors = post.errors.map do |attribute, message|
          path = ["attributes", attribute.to_s.camelize(:lower)]
          {
            path: path,
            message: message,
          }
        end
        {
          post: post,
          errors: user_errors
        }
      end
    end
  end
end
