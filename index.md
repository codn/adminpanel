---
layout: pages
title: Home
---
# [![CoDN](http://cl.ly/image/130Q0E153d2G/codn180.png)](http://www.codn.mx "CoDN")

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

* [Creating a New app](https://github.com/codn/adminpanel/wiki/Generator-adminpanel:initialize)

* [Creating new resources](https://github.com/codn/adminpanel/wiki/Generator-adminpanel:resource)

* [Adding fields to a resource](https://github.com/codn/adminpanel/wiki/Generator-adminpanel:migration)

* [Customizing your resources](https://github.com/codn/adminpanel/wiki/Adminpanel::Base-methods)

* [Preparing your application for production](https://github.com/codn/adminpanel/wiki/Generator-adminpanel:dump)

* [Rake tasks](https://github.com/codn/adminpanel/wiki/Rake-tasks-list-and-descriptions), useful actions.


## The available rake tasks are

`bundle exec rake`

* `adminpanel:section` [see details]({{site.baseurl}}{% post_url tasks/2015-01-09-section %})

* `adminpanel:user` creates and displays password for admin@codn.mx user to log in.

Any questions, errors or feature suggestions [are welcome in the issues](https://github.com/codn/adminpanel/issues/new)
