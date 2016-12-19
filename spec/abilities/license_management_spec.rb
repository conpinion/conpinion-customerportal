require 'rails_helper'
require 'rails_helper'
require 'cancan/matchers'

describe 'License management abilities' do
  let(:user) { nil }
  let(:distributor_user) { Fabricate :distributor_user }
  let(:distributor) { Fabricate :distributor, responsible: distributor_user }
  let(:customer_user) { Fabricate :customer_user }
  let(:customer) { Fabricate :customer, distributor: distributor, responsible: customer_user }
  let(:license) { Fabricate :license, customer: customer }

  subject(:ability) { Ability.new user }

  context 'when the user is not authenticated' do
    it { is_expected.not_to be_able_to :manage, License }
  end

  context 'when the user is a customer user' do
    let(:user) { Fabricate :customer_user }
    context 'who is not responsible for the license customer' do
      it { is_expected.not_to be_able_to :read, license }
    end
    context 'who is responsible for the license customer' do
      let(:customer_user) { user }
      it { is_expected.to be_able_to :read, license }
    end
  end

  context 'when the user is a distributor' do
    let(:user) { Fabricate :distributor_user }
    it { is_expected.to be_able_to :create, License }
    context 'who is not responsible for the license distributor' do
      it { is_expected.not_to be_able_to :modify, license }
    end
    context 'who is responsible for the license distributor' do
      let(:distributor_user) { user }
      it { is_expected.to be_able_to :modify, license }
      it { is_expected.to be_able_to :download, license }
      it { is_expected.not_to be_able_to :destroy, license }
    end
  end

  context 'when the user is an administrator' do
    let(:user) { Fabricate.build :admin_user }
    it { is_expected.to be_able_to :manage, license }
  end
end
