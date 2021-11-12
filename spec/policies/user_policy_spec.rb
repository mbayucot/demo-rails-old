require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  subject { described_class.new(user, resource) }

  let(:resolved_scope) { described_class::Scope.new(user, User.all).resolve }

  let(:resource) { create(:user) }

  context 'being an author' do
    let(:user) { create(:user, role: :author) }

    it { is_expected.to permit_actions(%i[show create update]) }
  end

  context 'being an editor' do
    let(:user) { create(:user, role: :editor) }

    it 'includes resource in resolved scope' do
      expect(resolved_scope).to include(resource)
    end

    it { is_expected.to permit_actions(%i[index show create update]) }
  end

  context 'being an admin' do
    let(:user) { create(:user, role: :admin) }

    it 'includes resource in resolved scope' do
      expect(resolved_scope).to include(resource)
    end

    it { is_expected.to permit_actions(%i[index show create update destroy]) }
  end
end
