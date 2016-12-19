require 'rails_helper'

describe CommunicationHangupCommand do

  let(:peer_id) { 1 }
  let(:params) { { peer_id: peer_id } }
  let(:command) { CommunicationHangupCommand.new params }

  subject { command }

  it { is_expected.to respond_to :peer_id }
  it { is_expected.to respond_to :peer_name }
  it { is_expected.to be_valid }

  describe 'if no peer is specified' do
    let(:peer_id) { nil }
    it { is_expected.not_to be_valid }
  end
end
