module Taxis
  module ControllerHelpers

    def tree_children(taxon)
      children = []
      taxon.children.each do |taxon|
        children << {
          :attr => {:id => taxon.id.to_s},
          :data => taxon.name,
          :state => taxon.children.empty? ? "" : "closed"
        }
      end
      
      return children
    end

  end
end
