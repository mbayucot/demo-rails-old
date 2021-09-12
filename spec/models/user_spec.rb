require 'rails_helper'

RSpec.describe User, type: :model do
  it do
    expect(subject).to define_enum_for(:role).with_values(
      customer: 0, staff: 1, admin: 2
    )
  end
end
