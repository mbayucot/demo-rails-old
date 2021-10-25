class UserSerializer < ActiveModel::Serializer

  attributes :id, :email, :first_name, :last_name, :role, :role_fmt, :name, :created_at, :updated_at

  def role_fmt
    object.role.capitalize
  end
end
