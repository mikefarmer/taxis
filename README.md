# Taxis
Taxis is a simple Rails 3 plugin that will give you a taxonomy structure for your rails application. It was written with the intent of providing a category tree for e-commerce solutions.  It is in early development right now so please feel free to submit issues and provide any feedback.

# Installation

    gem install taxis
    
    rails g taxis:install
    
# Dependencies
Taxis provides a very simple interface for administrating the taxonomy. This interface uses the jsTree javascript library, which is a plugin for jQuery.  As such, the taxis:install generator installs the jquery-rails gem which removes the prototype framework from your application. If this is not desired, use the --skip-jquery option when you run the generator.  The gem also depends on:

 * stringex
 * nested_set

# Credit
Taxis is heavily based off the taxonomy system originally written by Sonny Cook as currently implemented in Spree (http://spreecommerce.com/). While much of the views are the same, the admin controllers and models have been written from the ground up to isolate functionality only needed for the gem.

# Contributing
Fork, modify, send me a pull request


