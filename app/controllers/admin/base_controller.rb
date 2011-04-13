class Admin::BaseController < ApplicationController
  layout 'admin'

  # For the gem
  unloadable



  protected


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
