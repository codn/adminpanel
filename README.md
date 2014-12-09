# [![CoDN](http://cl.ly/image/130Q0E153d2G/codn180.png)](http://www.codn.mx "CoDN") Adminpanel

Thank you for considering this gem, we are going to use the lastest Rails version of Rails. make sure you can use it before trying this gem out.

[![Gem Version](https://badge.fury.io/rb/adminpanel.svg)](http://badge.fury.io/rb/adminpanel)
[![Build Status](https://travis-ci.org/joseramonc/adminpanel.svg?branch=master)](https://travis-ci.org/joseramonc/adminpanel)
[![Code Climate](https://codeclimate.com/github/joseramonc/adminpanel/badges/gpa.svg)](https://codeclimate.com/github/joseramonc/adminpanel)
<!-- [![Dependency Status](https://gemnasium.com/joseramonc/adminpanel.svg)](https://gemnasium.com/joseramonc/adminpanel) -->
## Installation

Add this line to your application's Gemfile:

    gem 'adminpanel'

And then execute:

    $ bundle

## Usage

In you application.rb

    config.i18n.default_locale = :es # or :en

no other language is currently supported, but pull requests are welcome.

Then run:

    rails g adminpanel:initialize
    rake db:migrate
to create the database that the adminpanel it's expecting, this will also seed the database with the default user (email: 'admin@admin.com', password: 'password').

Make sure you read the wiki, there is the descriptions of every relevant part of the gem.

To create a new resource check the [Resource Generator.](https://github.com/joseramonc/adminpanel/wiki/Generator-adminpanel:resource)

You can seed the sections with help of the [Section task.](https://github.com/joseramonc/adminpanel/wiki/Rake-task-adminpanel:section)

Then, mount the gem wherever you like!

    mount Adminpanel::Engine => '/panel'

## Dependencies

Please make sure that you have ImageMagick -v 2.13.2 installed before trying to use the gem.

## Integrated APIs

Currently the integrations working are:

* [Google Analytics Service](https://github.com/joseramonc/adminpanel/wiki/include-Google-Analytics)
* [Facebook Share Link to Wall](https://github.com/joseramonc/adminpanel/wiki/include-Adminpanel::Facebook)
* [Twitter API](https://github.com/joseramonc/adminpanel/wiki/include-Adminpanel::Twitter)
* [Instagram API](https://github.com/joseramonc/adminpanel/wiki/include-Adminpanel::Instagram)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Any questions, errors or feature suggestions [are welcome in the issues](https://github.com/joseramonc/adminpanel/issues/new)
