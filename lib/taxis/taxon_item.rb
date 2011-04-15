module Taxis
  class TaxonItem < ActiveRecord::Base
    belongs_to :taxon

    validates_presence_of :taxonable_type, :message => "is required. Try the attach() method on a Taxon object. "
  end

end
