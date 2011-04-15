class Product < ActiveRecord::Base
  has_many :taxons,
    :through => :taxon_items,
    :foreign_key => "taxonable_id",
    :conditions => "taxonable_type = 'Product'"

end
