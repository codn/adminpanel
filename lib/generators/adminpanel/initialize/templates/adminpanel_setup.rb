Adminpanel.setup do |config|
  # # You get this from the Google Analytics Dashboard, this configuration is required.
  # config.analytics_profile_id = '12341234'

  # # The next configuration is the file used to establish server to server authentication/authorization
  # # you need to download this file from the Google Developers Console
  # # and place it inside your application, this configuration is required.
  # config.analytics_key_filename = '12345ABCDE.p12'

  # # Path to the key file, defaults to config/analytics
  # config.analytics_key_path = "config/analytics"

  # # Facebook app id
  # config.fb_app_id = '1234'

  # # Facebook app secret *MAKE SURE TO DON'T SHARE THIS SECRET*
  # config.fb_app_secret = '1234'

  # # This are the modules that are going to be displayed and order that are going to be displayed
  config.displayable_resources = [
    :analytics,
    :users,
    :galleries,
    :sections
  ]
end
