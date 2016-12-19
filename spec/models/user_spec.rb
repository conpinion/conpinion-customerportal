require 'rails_helper'

describe User do
  let(:user) { Fabricate :user, family_name: 'Alice Agarwal' }

  subject { user }

  it { is_expected.to respond_to :email }
  it { is_expected.to respond_to :family_name }
  it { is_expected.to respond_to :password }
  it { is_expected.to respond_to :role_symbols }
  it { is_expected.to respond_to :roles_mask }
  it { is_expected.to respond_to :new_email }
  it { is_expected.to respond_to :new_password }
  it { is_expected.to respond_to :current_password }
  it { is_expected.to be_valid }

  describe 'with an empty email' do
    before { user.email = '' }
    it { is_expected.not_to be_valid }
  end

  describe 'new user with an empty password' do
    let(:user) { Fabricate.build :user, password: '' }
    it { is_expected.not_to be_valid }
  end

  describe 'with an invalid new email' do
    before { user.new_email = 'abc' }
    it { is_expected.not_to be_valid }
  end

  describe '#display_name' do
    its(:display_name) { is_expected.to eq 'Alice Agarwal' }
  end

  describe '#online?' do
    context 'the user is online (active during the last 5 minutes)' do
      before { user.update_attribute :last_seen, 4.minutes.ago }
      its(:online?) { is_expected.to be_truthy }
    end
    context 'the user is offline (inactive since the last 5 minutes)' do
      before { user.update_attribute :last_seen, 6.minutes.ago }
      its(:online?) { is_expected.to be_falsey }
    end
  end

  describe '::admins' do
    let!(:user1) { Fabricate :user }
    let!(:admin_user1) { Fabricate :admin_user }
    let!(:admin_user2) { Fabricate :admin_user }
    it 'should return all admin users' do
      expect(User.admins.to_a).to match_array [admin_user1, admin_user2]
    end
  end

  describe '::online' do
    let!(:user1) { Fabricate :user, last_seen: 4.minutes.ago }
    let!(:user2) { Fabricate :user, last_seen: 6.minutes.ago }
    let!(:user3) { Fabricate :user, last_seen: 1.minutes.ago }
    it 'should return all online users' do
      expect(User.online.to_a).to match_array [user1, user3]
    end
  end

  describe '::select_available_admin' do
    let!(:admin_user1) { Fabricate :admin_user, last_seen: 1.minutes.ago }
    let!(:admin_user2) { Fabricate :admin_user, last_seen: 8.minutes.ago }
    let!(:admin_user3) { Fabricate :admin_user, last_seen: 4.minutes.ago }
    let!(:admin_user4) { Fabricate :admin_user, last_seen: 2.minutes.ago }
    before { allow(User).to receive(:rand).and_return 1 }
    it 'should return a random online admin user' do
      expect(User.select_available_admin).to eq admin_user3
    end
  end
end
