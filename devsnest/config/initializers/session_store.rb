# frozen_string_literal: true

Rails.application.config.session_store :cookie_store, key: '_interslice_session', domain: '.devsnest.in', tld_length: 2
Rails.application.config.session_store :cookie_store, key: '_devsnest_session', domain: '.devsnest.in', tld_length: 2