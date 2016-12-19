class CommunicationHangupCommand < BaseCommand
  attribute :peer_id, Integer
  attribute :peer_name, String

  validates :peer_id, presence: true

  def execute
    return false unless valid?
    ActionCable.server.broadcast "communication_#{peer_id}", {
      action: 'hangup'
    }
    true
  end
end
