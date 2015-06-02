OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['713089765483521'], ENV['5689346eeb56472e580415bd34af187b']
end

