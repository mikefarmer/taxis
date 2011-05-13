class CreateTaxonomies < ActiveRecord::Migration
  def self.up
    create_table :taxonomies do |t|
      t.string :name
      t.text :description
      t.timestamps
    end

    add_index :taxonomies, :name
  end

  def self.down
    drop_table :taxonomies
  end
end
