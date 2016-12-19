# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, key: '_conpinion-customerportal_session',
  expire_after: Figaro.env.session_timeout.to_i.minutes
