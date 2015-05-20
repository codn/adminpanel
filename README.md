# [![CoDN](http://cl.ly/image/130Q0E153d2G/codn180.png)](http://www.codn.mx "CoDN") Adminpanel

This gem uses use the lastest version of Rails. [Usage Docs](http://codn.github.io/adminpanel).

[![Gem Version](https://badge.fury.io/rb/adminpanel.svg)](http://badge.fury.io/rb/adminpanel)
[![Build Status](https://travis-ci.org/codn/adminpanel.svg?branch=master)](https://travis-ci.org/codn/adminpanel)
[![Code Climate](https://codeclimate.com/github/codn/adminpanel/badges/gpa.svg)](https://codeclimate.com/github/codn/adminpanel)
<!-- [![Dependency Status](https://gemnasium.com/codn/adminpanel.svg)](https://gemnasium.com/codn/adminpanel) -->
## Installation

Add this line to your application's Gemfile:

    gem 'adminpanel'

And then execute:

    $ bundle

Run:

    rails g adminpanel:initialize
    rake db:migrate
This create and seeds a user to the database (email: 'admin@admin.com', password: 'password').
    
#### Optional

Change the path where adminpanel is mounted

    # routes.rb
    mount Adminpanel::Engine => '/panel'

Change the panel locale

    # application.rb
    # Adminpanel supported locales :en, :es (pull requests are welcome)
    config.i18n.default_locale = :es

## Usage

To create a new resource: 
```
rails g adminpanel:resource product name price:float description:wysiwyg
```
check the [Resource Generator docs](http://codn.github.io/adminpanel/generator/resource) for more information.

Make sure you [read the docs](http://codn.github.io/adminpanel), there is the descriptions of every relevant part of the gem.

## Dependencies

* Imagemagick
* Ruby 2.1.0+
* Rails 4.2+

## Integrated APIs

Currently the integrations working are:

* [Google Analytics Service](http://codn.github.io/adminpanel/module/google-analytics.html)
* [Facebook Share Link to Wall](http://codn.github.io/adminpanel/module/facebook)
* [Twitter API](http://codn.github.io/adminpanel/module/twitter)
* [Instagram API](http://codn.github.io/adminpanel/module/instagram)

Any questions, errors or feature suggestions [are welcome in the issues](https://github.com/codn/adminpanel/issues/new)
