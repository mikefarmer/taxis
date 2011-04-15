require 'rails/generators'
require 'rails/generators/migration'

module Taxis
  class MigrationGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'templates')
    end

    def self.next_migration_number(dirname)
      @sequence ||= 0
      @sequence += 1
      # Replace the last second with the sequence number
      # so that you don't get duplicate version numbers'
      Time.now.utc.strftime("%Y%m%d%H%M%S").chop + @sequence.to_s
    end

    def create_migration_file
      migration_template 'create_taxonomies.rb', 'db/migrate/create_taxonomies.rb'
      migration_template 'create_taxons.rb', 'db/migrate/create_taxons.rb'
      migration_template 'create_taxon_items.rb', 'db/migrate/create_taxon_items.rb'
    end

   


  end
end

