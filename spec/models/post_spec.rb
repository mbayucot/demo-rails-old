require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'includes' do
    it { expect(subject.class).to include(AASM) }
    it { expect(subject.class).to include(PgSearch::Model) }
  end

  describe 'associations' do
    it do
      expect(subject).to belong_to(:user)
    end

    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:body) }
  end
end
