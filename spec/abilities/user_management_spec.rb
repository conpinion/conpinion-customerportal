require 'rails_helper'
require 'rails_helper'
require 'cancan/matchers'

describe 'User management abilities' do
  let(:user) { nil }

  subject(:ability) { Ability.new user }

  context 'when the user is not authenticated' do
    let(:another_user) { Fabricate :customer_user }
    it { is_expected.not_to be_able_to :manage, another_user }
  end

  context 'when the user is a customer' do
    let(:user) { Fabricate :customer_user }
    let(:another_user) { Fabricate :customer_user }
    it { is_expected.not_to be_able_to :create, User }
    it { is_expected.not_to be_able_to :manage, another_user }
    it { is_expected.not_to be_able_to :edit_email, another_user }
    it { is_expected.not_to be_able_to :edit_password, another_user }
    it { is_expected.to be_able_to :show, user }
    it { is_expected.to be_able_to :edit_email, user }
    it { is_expected.to be_able_to :edit_password, user }
    it { is_expected.to be_able_to :update, user }
    it { is_expected.not_to be_able_to :delete, user }
  end

  context 'when the user is a distributor' do
    let(:user) { Fabricate :distributor_user }
    let(:another_user) { Fabricate :customer_user }
    it { is_expected.not_to be_able_to :create, User }
    it { is_expected.not_to be_able_to :manage, another_user }
    it { is_expected.not_to be_able_to :edit_email, another_user }
    it { is_expected.not_to be_able_to :edit_password, another_user }
    it { is_expected.to be_able_to :show, user }
    it { is_expected.to be_able_to :edit_email, user }
    it { is_expected.to be_able_to :edit_password, user }
    it { is_expected.to be_able_to :update, user }
    it { is_expected.not_to be_able_to :delete, user }
  end

  context 'when the user is an administrator' do
    let(:user) { Fabricate.build :admin_user }
    let(:another_user) { Fabricate :customer_user }
    it { is_expected.to be_able_to :create, User }
    it { is_expected.to be_able_to :manage, another_user }
    it { is_expected.to be_able_to :edit_email, another_user }
    it { is_expected.to be_able_to :edit_password, another_user }
    it { is_expected.to be_able_to :manage, user }
    it { is_expected.to be_able_to :edit_email, user }
    it { is_expected.to be_able_to :edit_password, user }
    it { is_expected.not_to be_able_to :destroy, user }
  end
end
