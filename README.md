# Adminpanel

This gem is developed to be a CMS for Ruby 1.8.7 and Rails 3.2.12 

[![Travis CI   ](https://api.travis-ci.org/joseramonc/adminpanel.png)       ](https://travis-ci.org/joseramonc/adminpanel)

## Installation

Add this line to your application's Gemfile:

    gem 'adminpanel'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install adminpanel

## Usage

In you application.rb 

    config.default_locale = :es
no other language is currently supported, but pull requests are welcome.

Then run:

    rails g adminpanel:install create_migrations
    rake db:migrate
to create the database that the adminpanel it's expecting, this will also seed the database with the default user.

You can seed the sections with help of the [Section wiki](https://github.com/joseramonc/adminpanel/wiki/Section-objects).



Then, mount the gem wherever you like!

    mount Adminpanel::Engine => "/admin"

Also make sure to include adminpanel assets in your application.rb if you need to precompile them:

    config.assets.precompile += ['application-admin.js', 'application-admin.css']
The version 0.1.0 is the first stable version, feel free to use it, any doubts or errors feel free to ask me!.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## To Do:

1. Add english support
2. Get a model generator or some kind of it
3. Make a mount_uploader like, that make the relationship of a model with Adminpanel::Image so we get cleaner models