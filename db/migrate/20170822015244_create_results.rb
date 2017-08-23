class CreateResults < ActiveRecord::Migration[5.1]
  def change
    create_table :results do |t|
      t.integer :listing_id
      t.string :address
      t.decimal :price
      t.decimal :bedrooms
      t.decimal :bathrooms
      t.decimal :garage
      t.string :type
      t.string :subtype
      t.decimal :lot_size
      t.integer :square_feet
      t.string :year_built
      t.string :school_district
      t.string :subdivision
      t.text :description

      t.timestamps
    end
  end
end
