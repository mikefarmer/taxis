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

    add_index :taxons, :name, :unique => true
    add_index :taxons, :path, :unique => true
    add_index :taxons, :url, :unique => true
    add_index :taxons, :taxonomy_id
    add_index :taxons, :parent_id
    add_index :taxons, :lft
    add_index :taxons, :rgt
    add_index :taxons, :root_id
  end

  def self.down
    drop_table :taxons
  end
end
