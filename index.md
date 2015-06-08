---
layout: pages
title: Home
---
# [![CoDN](http://cl.ly/bZ23/codn.svg)](http://www.codn.mx "CoDN")

### This gem was created and is mantained by CoDN

## Installation

Add this line to your application's Gemfile:

    gem 'adminpanel'

And then execute:

    $ bundle

Run:

    rails g adminpanel:initialize
    rake db:migrate
This create and seeds a user to the database (email: 'admin@admin.com', password: 'password').

**NOTE THAT THIS GEM DEPENDS ON ImageMagick SO MAKE SURE YOU HAVE IT BEFORE ADDING ADMINPANEL TO YOUR GEMFILE**

The core parts of this documentation are:

* [Creating a New app](http://blog.codn.mx/adminpanel/generator/initialize-generator.html)

* [Creating new resources](http://blog.codn.mx/adminpanel/generator/resource.html)

* [Adding fields to a resource](http://blog.codn.mx/adminpanel/generator/migration.html)

* [Customizing your resources](https://github.com/codn/adminpanel/wiki/Adminpanel::Base-methods)

* [Preparing your application for production](http://blog.codn.mx/adminpanel/generator/dump.html)


## The available rake tasks are

`bundle exec rake`

* `adminpanel:section` [see details]({{site.baseurl}}{% post_url tasks/2015-01-09-section %})

* `adminpanel:user` creates and displays password for admin@codn.mx user to log in.

Any questions, errors or feature suggestions [are welcome in the issues](https://github.com/codn/adminpanel/issues/new)
