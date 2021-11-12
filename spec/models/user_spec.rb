require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'enumbs' do
    it do
      expect(subject).to define_enum_for(:role).with_values(
        author: 1, editor: 2, admin: 3
      )
    end
  end

  describe 'associations' do
    it { expect(subject).to have_many(:posts).dependent(:destroy) }
    it { expect(subject).to have_many(:comments).dependent(:destroy) }
    it { expect(subject).to have_many(:subscriptions).dependent(:destroy) }
  end
end
