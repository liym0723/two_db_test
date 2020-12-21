class CreateElasticsearchTestTables < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :store_code
      t.text :full_description
      t.boolean :published
      t.integer :display_order
      t.date :display_start_at
      t.date :display_end_at
      t.integer :price

      t.datetime :deleted_at
      t.timestamps
    end

    create_table :product_properties do |t|
      t.integer :product_id
      t.integer :property_id

      t.datetime :deleted_at
      t.timestamps
    end

    create_table :properties do |t|
      t.string :name

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
