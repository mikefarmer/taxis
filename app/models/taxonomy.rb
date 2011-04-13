class Taxonomy < ActiveRecord::Base
  has_many :taxons
  has_one :root, :class_name => 'Taxon', :conditions => "parent_id is null"


  after_create :create_root_taxon
  before_destroy :delete_taxons

  def create_root_taxon
    self.taxons.create(:name => self.name + "__root")
  end


  # Doing this through a callback because it doesn't 
  # rely on the destroy conditions of the taxons and
  # makes deleting much more efficient
  def delete_taxons
    # TODO: More to do here. 
    # We probably will want to ensure that any items
    # assigned to the taxons get reassigned or cleaned
    # up appropriately.
    Taxon.destroy_all(:taxonomy_id => self.id)
  end
end
