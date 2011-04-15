class CreateTaxonItems < ActiveRecord::Migration
  def self.up
    create_table :taxon_items do |t|
      t.integer :taxon_id, :taxonable_id
      t.string :taxonable_type
    end
  end

  def self.down
    drop_table :taxon_items
  end

end
