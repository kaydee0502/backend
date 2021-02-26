# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "#{ENV['FRONTEND_URL']}, https://devsnest-frontend.vercel.app/"

    resource 'devsnest.in, devsnest-frontend.vercel.app',
             headers: :any,
             methods: %i[get post put patch delete options head]
  end
end

