require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it do
      expect(subject).to have_many(:articles).with_foreign_key('author_id')
                                             .dependent(:destroy)
    end
    it do
      expect(subject).to have_many(:comments).with_foreign_key('author_id')
                                             .dependent(:destroy)
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end
end
