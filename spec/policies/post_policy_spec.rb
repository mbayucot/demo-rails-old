require 'rails_helper'

RSpec.describe PostPolicy, type: :policy do
  subject { described_class.new(user, post) }

  let(:resolved_scope) { described_class::Scope.new(user, Post.all).resolve }

  let(:post) { create(:post) }

  context 'being an author' do
    let(:user) { create(:user, role: :author) }
    let(:post) { create(:post, user_id: user.id) }

    it 'includes post in resolved scope' do
      expect(resolved_scope).to include(post)
    end

    it { is_expected.to permit_actions(%i[index show create update destroy]) }
  end

  context 'being an editor' do
    let(:user) { create(:user, role: :editor) }

    it 'includes post in resolved scope' do
      expect(resolved_scope).to include(post)
    end

    it { is_expected.to permit_actions(%i[index show]) }
  end

  context 'being an admin' do
    let(:user) { create(:user, role: :admin) }

    it 'includes post in resolved scope' do
      expect(resolved_scope).to include(post)
    end

    it { is_expected.to permit_actions(%i[index show update destroy]) }
  end
end
