require 'nested_set'
require 'stringex'
module Taxis
  class Taxon < ActiveRecord::Base


    acts_as_nested_set :dependent => :destroy

    acts_as_url :name, :sync_url => true


    belongs_to :taxonomy
    has_many :taxon_items

    before_create :set_path, :set_taxonomy
    after_create :set_root
    before_update :set_path



    # TODO: I don't love this implementation as it doesn't allow for effective navigation up the tree
    # but it does provide a nice url breadcrumb trail


    # Creates path based on .to_url method provided by stringx gem
    def set_path

      if self.root? 
        self.path = '/' 
      else
        ancestor_path = parent_taxon.path rescue "/"
        sep = ancestor_path == "/" ? "" : "/"
        self.path = ancestor_path + sep + self.url
      end

    end

    def set_taxonomy
      if ! self.root?
        self.root_id = parent_taxon.root_id
        self.taxonomy_id = parent_taxon.taxonomy_id
      end
    end

    def set_root
      self.root_id = self.id if self.root?
      save
    end


    # Attaches any ActiveRecord class to a taxon
    def attach(klass)
      self.taxon_items.create(:taxonable_type => klass.class.to_s, :taxonable_id => klass[:id])
      klass.reload
      self.reload
      return klass
    end

    # Removes an attached ActiveRecord object from a taxon
    def detatch(klass)
      ti = self.taxon_items.where(:taxonable_type => klass.class.to_s, :taxonable_id => klass[:id]).first
      ti.delete if ti
      klass.reload
      self.reload
      return klass
    end


    def method_missing(obj, *args)
      if obj.match(/attached_(.*)/)
        table_name = $1
        class_name = table_name.classify
        klass = Kernel.const_get(class_name)
        records = klass.find_by_sql <<-SQL
          SELECT n.* 
          FROM #{table_name} n 
          JOIN taxon_items ti ON ti.taxonable_id = n.id AND taxonable_type = '#{class_name}'
        SQL

        return records || []

      else
        super
      end
    end



    private

    def parent_taxon
      @parent_taxon ||= Taxon.find(self.parent_id)
    end





  end

end
