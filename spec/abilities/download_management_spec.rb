require 'rails_helper'
require 'rails_helper'
require 'cancan/matchers'

describe 'Download management abilities' do
  let(:user) { nil }
  let(:distributor_user) { Fabricate :distributor_user }
  let(:distributor) { Fabricate :distributor, responsible: distributor_user }
  let(:customer_user) { Fabricate :customer_user }
  let(:download) { Fabricate :download }

  subject(:ability) { Ability.new user }

  context 'when the user is not authenticated' do
    it { is_expected.not_to be_able_to :manage, Download }
  end

  context 'when the user is a customer user' do
    let(:user) { Fabricate :customer_user }
    it { is_expected.not_to be_able_to :create, Download }
    it { is_expected.not_to be_able_to :update, download }
    it { is_expected.not_to be_able_to :destroy, download }
    it { is_expected.to be_able_to :read, download }
    it { is_expected.to be_able_to :download, download }
  end

  context 'when the user is a distributor' do
    let(:user) { Fabricate :distributor_user }
    it { is_expected.not_to be_able_to :create, Download }
    it { is_expected.not_to be_able_to :update, download }
    it { is_expected.not_to be_able_to :destroy, download }
    it { is_expected.to be_able_to :read, download }
    it { is_expected.to be_able_to :download, download }
  end

  context 'when the user is an administrator' do
    let(:user) { Fabricate.build :admin_user }
    it { is_expected.to be_able_to :manage, download }
  end
end
