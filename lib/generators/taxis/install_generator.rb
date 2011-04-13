require 'rails/generators'

module Taxis

  class InstallGenerator < Rails::Generators::Base
    desc "Installs the javascript files and creates the database migrations for taxis"

    class_option :skip_jquery, :type => :boolean, :default => false, :desc => "Skip the jQuery Install"

    def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'public')
    end


    def ensure_jquery_gem
      unless options[:skip_jquery]
        if ! defined? Jquery
          gem 'jquery-rails', '>= 0.2.6'

          jqry_msg = <<-TXT
The taxis default admin views require jquery for their use. As such, jquery-rails
was added to your gemfile.  You need to run "bundle install" and rerun this generator
to finish installing taxis. If you don't want to use jquery, you can provide the --skip-jquery
option when running the generator, but this will break the admin views.
NOTE: This will also remove the prototype javascript framework from your application.
See https://github.com/indirect/jquery-rails for more information.
TXT


          say jqry_msg, :red
          exit
        else
          generate "jquery:install"
        end
      end
    end
    
    def copy_taxonomy_js
      copy_file 'taxonomy.js', 'public/javascripts/taxonomy.js'
    end

    def copy_js_tree
      dest_root = "public/javascripts/jsTree/"
      files = [ 
        'jquery.jstree.js',
        'themes/apple/bg.jpg',
        'themes/apple/d.png',
        'themes/apple/dot_for_ie.gif',
        'themes/apple/style.css',
        'themes/apple/throbber.gif',
      ]

      files.each do |file|
        copy_file 'jsTree/' + file, dest_root + file
      end


    end

    def run_migration_install
      generate "taxis:migration"
    end



  end
end
