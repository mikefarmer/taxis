# Taxis
Taxis is a simple Rails 3 plugin that will give you a taxonomy structure for your rails application. It was written with the intent of providing a category tree for e-commerce solutions.  It is in early development right now so please feel free to submit issues and provide any feedback.

# Installation

    gem install taxis
    
    rails g taxis:install
    
# Dependencies
Taxis provides a very simple interface for administrating the taxonomy. This interface uses the jsTree javascript library, which is a plugin for jQuery.  As such, the taxis:install generator installs the jquery-rails gem which removes the prototype framework from your application. If this is not desired, use the --skip-jquery option when you run the generator.  The gem also depends on:

 * stringex
 * nested_set

# License

Copyright (C) 2011 by End Point Corporation

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.


# Contributing
Fork, modify, send me a pull request


