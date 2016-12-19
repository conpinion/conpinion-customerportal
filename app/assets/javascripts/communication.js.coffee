$(document).on 'turbolinks:load', ->
  if $('.communication_view.join_action').length
    muteAudioButton = $('#mute-audio')
    muteAudioIcon = $('#mute-audio-icon')
    muteVideoButton = $('#mute-video')
    muteVideoIcon = $('#mute-video-icon')
    hangupForm = $('.communication_hangup_command')
    communicationVideos = $('.communication-videos')

    webrtc = new SimpleWebRTC
      url: $('meta[name="x-simplewebrtc-url"]').attr 'content'
      remoteVideosEl: 'communication-remote-videos'
      localVideoEl: 'communication-local-video'
      autoRequestMedia: true
      video: true
      audio: true
    webrtc.on 'readyToCall', =>
      webrtc.joinRoom('conpinion-customerportal-room');
    communicationVideos.data webrtc

    muteAudioButton.click ->
      muteAudioIcon.toggleClass 'hidden'
      if muteAudioIcon.hasClass('hidden') then webrtc.unmute() else webrtc.mute()

    muteVideoButton.click ->
      muteVideoIcon.toggleClass 'hidden'
      if muteVideoIcon.hasClass('hidden') then webrtc.resumeVideo() else webrtc.pauseVideo()

    hangupForm.submit (e) ->
      webrtc.stopLocalVideo()
      webrtc.disconnect()
