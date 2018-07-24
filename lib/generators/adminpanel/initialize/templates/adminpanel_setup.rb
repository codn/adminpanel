Adminpanel.setup do |config|
  ### FACEBOOK CONFIGURATIONS ###
  # # Facebook app id
  # config.fb_app_id = 'f4c3b00k'

  # # Facebook app secret *MAKE SURE TO DON'T SHARE THIS SECRET*
  # config.fb_app_secret = 'fbs3cr3t'

  ### INSTAGRAM CONFIGURATIONS ###
  # # Instagram consumer key
  # config.instagram_client_id = '1nst4gr4m'

  # # Instagram consumer secret *YOU SHOULD KNOW BY NOW*
  # config.instagram_client_secret = '1nst4s3cr3t'

  # # This are the modules that are going to be displayed and order that are going to be displayed
  config.displayable_resources = [
    :analytics,
    :users,
    :roles,
    :permissions,
    #:auths,
    :sections
  ]

  config.displayable_pages = [
    # Adminpanel::HomePage,
    # Adminpanel::AboutUsPage,
    # Adminpanel::ContactPage
  ]
end
