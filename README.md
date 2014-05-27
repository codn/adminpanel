# Adminpanel

CMS for Rails 4, for rails 3.x check the corresponding branch.

[![Gem Version](https://badge.fury.io/rb/adminpanel.svg)](http://badge.fury.io/rb/adminpanel)
[![Build Status](https://travis-ci.org/joseramonc/adminpanel.svg?branch=master)](https://travis-ci.org/joseramonc/adminpanel)
[![Dependency Status](https://gemnasium.com/joseramonc/adminpanel.svg)](https://gemnasium.com/joseramonc/adminpanel)
[![Code Climate](https://codeclimate.com/github/joseramonc/adminpanel.png)](https://codeclimate.com/github/joseramonc/adminpanel)
## Installation

Add this line to your application's Gemfile:

    gem 'adminpanel'

And then execute:

    $ bundle

## Usage

In you application.rb

    config.default_locale = :es # or :en

no other language is currently supported, but pull requests are welcome.

Then run:

    rails g adminpanel:initialize
    rake db:migrate
to create the database that the adminpanel it's expecting, this will also seed the database with the default user.

Make sure you read the wiki, there is the descriptions of every relevant part of the gem.

To create a new resource check the [Resource Generator.](https://github.com/joseramonc/adminpanel/wiki/Generator-adminpanel:resource)

You can seed the sections with help of the [Section task.](https://github.com/joseramonc/adminpanel/wiki/Rake-task-adminpanel:section)

Then, mount the gem wherever you like!

    mount Adminpanel::Engine => "/codn"

Also make sure to include adminpanel assets in your application.rb if you need to precompile them:

    config.assets.precompile += ['application-admin.js', 'application-admin.css']
Feel free to use it, any doubts, errors or suggestions are welcome in the issues!

###Google Analytics Integration

To take advantage of the Integration with the Google Analytics Service you should add the analytics script to the public side of your application and then create an intializer called when you setup your authentication with Google

	# The configuration values you can provide are

	Adminpanel.setup do |config|
		# You get this from the Google Analytics Dashboard, this configuration is required.
		config.analytics_profile_id = '12341234'
		# The next configuration is the file used to establish server to server authentication/authorization
		# you need to download this file from the Google Developers Console
		# and place it inside your application, this configuration is required.
		config.analytics_key_filename = '12345ABCDE.p12'
		# Path to the key file, defaults to config/analytics
  		config.analytics_key_path = "config/analytics"
	end

Currently it only shows the visits from the last week, but more integrations will come.

For more information about using the Google API visit
* [Google Analytics API](https://developers.google.com/analytics/devguides/reporting/core/v3/)
* [Google API Ruby Client](https://github.com/google/google-api-ruby-client)
* [Google OAuth 2.0](https://developers.google.com/accounts/docs/OAuth2)
* [Google Developers Console](https://cloud.google.com/console)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## To Do:

#### Check the issues if you'd like to help or request a new feature.
