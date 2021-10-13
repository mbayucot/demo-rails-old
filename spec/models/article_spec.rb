require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'associations' do
    it do
      expect(subject).to belong_to(:user).class_name('User').with_foreign_key(
        'created_by'
      )
    end

    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title).scoped_to(:created_by) }
    it { is_expected.to validate_uniqueness_of(:body) }
  end
end
