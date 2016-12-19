require 'rails_helper'

describe CommunicationCallCommand do

  let(:caller) { Fabricate :admin_user }
  let(:callee) { Fabricate :online_user }
  let(:callee_id) { callee.id }
  let(:params) { { callee_id: callee_id, caller: caller } }
  let(:command) { CommunicationCallCommand.new params }

  subject { command }

  it { is_expected.to respond_to :caller }
  it { is_expected.to respond_to :callee_id }
  it { is_expected.to respond_to :callee }
  it { is_expected.to be_valid }

  describe 'if no caller is specified' do
    let(:caller) { nil }
    it { is_expected.not_to be_valid }
  end

  describe 'if the callee id matches the caller id' do
    let(:callee_id) { caller.id }
    it { is_expected.not_to be_valid }
  end

  describe 'if the callee id is invalid' do
    let(:callee_id) { -1 }
    it { is_expected.not_to be_valid }
  end

  describe 'if the callee is not online' do
    let(:callee) { Fabricate :offline_user }
    it { is_expected.not_to be_valid }
  end

  describe 'if the caller cannot call the callee' do
    let(:caller) { Fabricate :customer_user }
    it { is_expected.not_to be_valid }
  end

  describe 'if no callee id is specified' do
    let(:callee_id) { nil }

    context 'when the caller is an admin' do
      let(:caller) { Fabricate :admin_user }
      it { is_expected.not_to be_valid }
    end

    context 'when the caller is a distributor' do
      let(:caller) { Fabricate :distributor_user }

      context 'when there are online administrators' do
        let!(:online_admin) { Fabricate :online_admin_user }
        before { command.validate }
        it { is_expected.to be_valid }
        its(:callee) { is_expected.to eq online_admin }
      end

      context 'when there aren\'t any online administrators' do
        it { is_expected.not_to be_valid }
      end
    end

    context 'when the caller is a customer' do
      let(:caller) { Fabricate :customer_user }
      it { is_expected.not_to be_valid }
    end
  end
end
