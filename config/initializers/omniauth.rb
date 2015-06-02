OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1407920559534416', '30ba412f9f18766abbe0fa64ea35460d', info_fields: 'about,birthday,email,name,gender,location,cover'
end

