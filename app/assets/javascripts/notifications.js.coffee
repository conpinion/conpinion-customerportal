$ ->
  window.App || (window.App = {});
  window.App.notifications =
    vibrations:
      long: [1000]
      short: [500]
      warn: [500, 500, 500, 500, 500, 500, 500]

    notify: (text, sound, vibrate, timeout, extendedTimeOut) ->
      options = {}
      options['timeOut'] = timeout if timeout
      options['extendedTimeOut'] = extendedTimeOut if extendedTimeOut
      @vibrate vibrate if vibrate
      @playSound sound if sound
      @showPopup text, null, options if text

    toast: (title, text = null, options = {}) ->
      toastr.info text, title, options

    toastError: (title, text = null, options = {}) ->
      toastr.error text, title, options

    vibrate: (type) ->
      navigator.vibrate @vibrations[type]
      window.testVibrated()

    playSound: (file) ->
      sound = new Howl
        urls: [window.App.sounds["#{file}.wav"]]
      sound.play()
      window.testSoundPlayed()
