class Taxon < ActiveRecord::Base

  acts_as_nested_set :dependent => :destroy

  acts_as_url :name, :sync_url => true


  belongs_to :taxonomy

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

    #if parent_id.nil?
    #self.path = self.url if self.path.blank?
    #else
    #parent_taxon = Taxon.find(parent_id)
    #self.path = [parent_taxon.path, (self.path.blank? ? name.to_url : self.path.split("/").last)].join('/')
    #end
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



  private

  def parent_taxon
    @parent_taxon ||= Taxon.find(self.parent_id)
  end





end
