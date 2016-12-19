$ ->
  window.App.communicationChannel = window.App.cable.subscriptions.create "CommunicationChannel",
    received: (data) ->
      switch data.action
        when 'ring' then @_incomingCall data
        when 'hangup' then @_hangupCall data
        when 'answer' then @_answerCall data

    answer: (caller_id, callee_id) ->
      @perform 'answer',
        caller_id: caller_id,
        callee_id: callee_id

    decline: (caller_id, callee_id) ->
      @perform 'decline',
        caller_id: caller_id
        callee_id: callee_id

    _incomingCall: (data) ->
      @toast = window.App.notifications.toast I18n.t(
          'views.communication.incoming_call_from', name: data.caller_name),
        """
        <button type="button" class="btn btn-danger toast-decline-button">
          <i class="fa fa-close"></i>
          <span>#{I18n.t 'views.communication.decline'}</span>
        </button>
        <button type="button" class="btn btn-success toast-accept-button">
          <i class="fa fa-phone"></i>
          <span>#{I18n.t 'views.communication.accept'}</span>
        </button>
        """,
        timeOut: 0
        extendedTimeOut: 0
        onShown: ->
          $(@).find('.toast-decline-button').click =>
            window.App.communicationChannel.decline data.caller_id, data.callee_id
          $(@).find('.toast-accept-button').click =>
            window.App.communicationChannel.answer data.caller_id, data.callee_id
            window.location.href = Routes.communication_join_path peer_id: data.caller_id
      window.App.notifications.playSound 'ring'

    _hangupCall: (data) ->
      if $('.communication_hangup_command').length
        webrtc = $('.communication-videos').data()
        if webrtc
          webrtc.stopLocalVideo()
          webrtc.disconnect()
        window.location.href = '/communication/terminated'
      if $(@toast).is ':visible'
        toastr.clear @toast
        window.App.notifications.toastError I18n.t('views.communication.call_was_terminated')

    _answerCall: (data) ->
      window.location.href = Routes.communication_join_path peer_id: data.peer_id
