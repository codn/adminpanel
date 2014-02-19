# Adminpanel

This gem is developed to be a CMS for Ruby 1.8.7 and Rails 3.2.12 
[![Gem Version](https://badge.fury.io/rb/adminpanel.png)](http://badge.fury.io/rb/adminpanel)
[![Travis CI   ](https://api.travis-ci.org/joseramonc/adminpanel.png)       ](https://travis-ci.org/joseramonc/adminpanel)

## Installation

Add this line to your application's Gemfile:

    gem 'adminpanel'

And then execute:

    $ bundle

## Usage

In you application.rb 

    config.default_locale = :es
no other language is currently supported, but pull requests are welcome.

Then run:

    rails g adminpanel:initialize
    rake db:migrate
to create the database that the adminpanel it's expecting, this will also seed the database with the default user.

To create a new resource check the [resource generator wiki](https://github.com/joseramonc/adminpanel/wiki/Resource-Generator)

You can seed the sections with help of the [Section wiki](https://github.com/joseramonc/adminpanel/wiki/Section-objects).

Then, mount the gem wherever you like!

    mount Adminpanel::Engine => "/CoDN"

Also make sure to include adminpanel assets in your application.rb if you need to precompile them:

    config.assets.precompile += ['application-admin.js', 'application-admin.css']
Feel free to use it, any doubts, errors or requests you can open a new issue!

## Dependencies

Please make sure that you have (rmagick) ImageMagick -v 3.13.2 installed before trying to use the gem.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## To Do:

## Check the issues if you'd like to help or request a new feature.