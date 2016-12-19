class CommunicationController < ApplicationController
  def call
    @call = CommunicationCallCommand.new
  end

  def ring
    @call = CommunicationCallCommand.new call_params.to_h.merge({
      caller: current_user
    })
    @hangup = CommunicationHangupCommand.new peer_id: @call.callee_id
    unless @call.execute
      render :call
    end
  end

  def hangup
    @hangup = CommunicationHangupCommand.new hangup_params.to_h
    @hangup.execute
  end

  def terminated
    render :hangup
  end

  def join
    @hangup = CommunicationHangupCommand.new join_params.to_h
    @hangup.peer_name = User.find_by(id: @hangup.peer_id).display_name
  end

  private
  def call_params
    params.require(:communication_call_command).permit :callee_id
  end

  def hangup_params
    params.require(:communication_hangup_command).permit :peer_id
  end

  def join_params
    params.permit :peer_id, :mute_audio, :mute_video
  end
end
