Adminpanel.setup do |config|
  ### GOOGLE ANALYTICS CONFIGURATIONS ####
  # # You get this from the Google Analytics Dashboard, this configuration is required.
  # config.analytics_profile_id = '12341234'

  # # The next configuration is the file used to establish server to server authentication/authorization
  # # you need to download this file from the Google Developers Console
  # # and place it inside your application, this configuration is required.
  # config.analytics_key_filename = '12345ABCDE.p12'

  # # Path to the key file, defaults to config/analytics
  # config.analytics_key_path = "config/analytics"

  ### FACEBOOK CONFIGURATIONS ###
  # # Facebook app id
  # config.fb_app_id = 'f4c3b00k'

  # # Facebook app secret *MAKE SURE TO DON'T SHARE THIS SECRET*
  # config.fb_app_secret = 'fbs3cr3t'

  ### TWITTER CONFIGURATIONS ###
  # # Twitter consumer key
  # config.twitter_api_key = 'tw1tt3r'

  # # Twitter consumer secret *DON'T SHARE THIS SECRET EITHER*
  # config.twitter_api_secret = 'tws3cr3t'

  ### INSTAGRAM CONFIGURATIONS ###
  # # Instagram consumer key
  # config.instagram_client_id = '1nst4gr4m'

  # # Instagram consumer secret *YOU SHOULD KNOW BY NOW*
  # config.instagram_client_secret = '1nst4s3cr3t'

  # # This are the modules that are going to be displayed and order that are going to be displayed
  config.displayable_resources = [
    :analytics,
    :users,
    :rols,
    :permissions,
    :galleries,
    #:categories,
    :sections
  ]
end
