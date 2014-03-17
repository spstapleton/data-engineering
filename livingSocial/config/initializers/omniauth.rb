OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '178081594386.apps.googleusercontent.com', 'ntf9zkzfHs6N5Py44iaYOU21', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end