class Admin::TaxonomiesController < Admin::BaseController


  def index
    @taxonomies = Taxonomy.all 
  end

  def show
    @taxonomy = Taxonomy.find(params[:id])
  end

  def new
    @taxonomy = Taxonomy.new
  end

  def create
    @taxonomy = Taxonomy.new(params[:taxonomy])
    if @taxonomy.save
      redirect_to edit_admin_taxonomy_url(@taxonomy), :notice => "Successfully created taxonomy."
    else
      render :action => 'new'
    end
  end

  def edit
    @taxonomy = Taxonomy.find(params[:id])
    @tree = root_tree(@taxonomy)
  end

  def update
    @taxonomy = Taxonomy.find(params[:id])
    if @taxonomy.update_attributes(params[:taxonomy])
      redirect_to admin_taxonomies_url, :notice  => "Successfully updated taxonomy."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @taxonomy = Taxonomy.find(params[:id])
    @taxonomy.destroy
    redirect_to admin_taxonomies_url, :notice => "Successfully destroyed taxonomy."
  end
  

  private

  def root_tree(taxonomy)
    tree = {
      :attr => {:id => taxonomy.root.id.to_s, :rel => "root"},
      :data => taxonomy.root.name,
      :state => "open",
      :children => tree_children(taxonomy.root)
    }
    return tree
  end

end
