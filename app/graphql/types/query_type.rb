module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :posts, Types::PostType.collection_type, null: true do
      argument :page, Integer, required: false
      argument :query, String, required: false
      argument :sort, String, required: false
      argument :tag, String, required: false
    end

    field :post, PostType, null: false do
      argument :id, ID, required: true, as: :id
    end

    field :users, Types::UserType.collection_type, null: true do
      argument :page, Integer, required: false
      argument :query, String, required: false
    end

    field :user, UserType, null: false do
      argument :id, ID, required: true, as: :id
    end

    field :tags, [Types::TagType], null: true do
      argument :query, String, required: false
    end

    field :plans, [Types::PlanType], null: true do
    end

    def post(id:)
      post = ::Post.friendly.find(id)
      #post = Pundit.policy_scope!(context[:current_user], Post).friendly.find(id)
      Pundit.authorize context[:current_user], post, :show?
    end

    def user(id:)
      #user = id.present? ?
      #         Pundit.policy_scope!(context[:current_user], User).find(id) : context[:current_user]
      user = ::User.find(id)
      Pundit.authorize context[:current_user], user, :show?
    end

    def posts(page: 1, query: nil, sort: 'asc', tag: nil)
      if query.present?
        ::Post.search(query).page(page).order(updated_at: sort)
      elsif tag.present?
        ::Post.tagged_with(tag)
      else
        Pundit.policy_scope!(context[:current_user], ::Post).page(page).order(updated_at: sort)
      end
    end

    def users(page: 1, query: nil)
      user = Pundit.policy_scope!(context[:current_user], ::User)
      user.where("first_name ILIKE ?", "%#{query}%").page(page)
    end

    def tags(query: nil)
      ::ActsAsTaggableOn::Tag.where("name ILIKE ?", "%#{query}%")
    end

    def plans
      Stripe::Product.list({ active: true }).data
      Stripe::Plan.list({ active: true }).data
    end
  end
end
