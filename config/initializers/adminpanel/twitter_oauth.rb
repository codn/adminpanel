Rails.application.config.middleware.use OmniAuth::Builder do
  if !Adminpanel.twitter_api_key.nil? && !Adminpanel.twitter_api_secret.nil?
    provider(
      :twitter,
      Adminpanel.twitter_api_key,
      Adminpanel.twitter_api_secret,
      {
        authorize_params: {
          force_login: 'true',
          lang: I18n.default_locale.to_s
        }
      }
    )
  end
end
