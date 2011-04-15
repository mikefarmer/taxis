class CreateTaxons < ActiveRecord::Migration
  def self.up
    create_table :taxons do |t|
      t.string :name
      t.text :path
      t.string :url
      t.integer :taxonomy_id
      # for acts as set
      t.integer :parent_id, :lft, :rgt, :root_id
      t.timestamps

    end
  end

  def self.down
    drop_table :taxons
  end
end
