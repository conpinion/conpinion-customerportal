class CommunicationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "communication_#{current_user.id}"
  end

  def answer data
    ActionCable.server.broadcast "communication_#{data['caller_id']}", {
      action: 'answer',
      peer_id: data['callee_id']
    }
  end

  def decline data
    ActionCable.server.broadcast "communication_#{data['callee_id']}", {
      action: 'hangup'
    }
    ActionCable.server.broadcast "communication_#{data['caller_id']}", {
      action: 'hangup'
    }
  end
end
