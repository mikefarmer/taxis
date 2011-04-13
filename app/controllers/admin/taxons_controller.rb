class Admin::TaxonsController < Admin::BaseController

  before_filter :find_taxonomy, :except => [:children]

  def index

    if @taxonomy
      @taxons = @taxonomy.children.order(:pos)
    else
      @taxons = Taxon.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @taxons}
    end
    
    
  end

  def show
    @taxon = Taxon.find(params[:id])
  end

  def new
    @taxon = Taxon.new
  end

  def create
    @taxon = Taxon.new(params[:taxon])
    if @taxon.save
      redirect_to edit_admin_taxonomy_url(@taxon.taxonomy), :notice => "Successfully created taxon."
    else
      render :action => 'new'
    end
  end

  def edit
    @taxon = Taxon.find(params[:id])
    @taxonomy = @taxon.taxonomy
  end

  def update
    @taxon = Taxon.find(params[:id])
    if @taxon.update_attributes(params[:taxon])

      # Move the taxon to the correct position
      if params[:left_of_id] != params[:parent_id]
        @right_taxon = Taxon.find(params[:left_of_id])
        @taxon.move_to_left_of(@right_taxon) if @right_taxon && @taxon.siblings.include?(@right_taxon)
      end

      if params[:format] == :json
        render :json => "ok"
      else
        redirect_to edit_admin_taxonomy_url(@taxon.taxonomy), :notice  => "Successfully updated taxon."
      end
    else
      render :action => 'edit'
    end
  end

  def destroy
    @taxon = Taxon.find(params[:id])
    @taxon.destroy
    redirect_to edit_admin_taxonomy_url(@taxon.taxonomy), :notice => "Successfully destroyed taxon."
  end


  # Action for getting the children of a taxon
  # right now it only responds to json requests
  def children
    @taxon = Taxon.find params[:id]
    @children = @taxon.children
    @tree = tree_children(@taxon)
    respond_to do |format|
      format.html
      format.json { render :json => @tree }
    end
    
  end


  private 

  def find_taxonomy
    if params[:taxonomy_id]
      @taxonomy = Taxonomy.find(params[:taxonomy_id]) 
    else
      @taxonomy = nil
    end
  end

end
