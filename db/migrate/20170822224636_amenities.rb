class Amenities < ActiveRecord::Migration[5.1]
  def change
    create_table :amenities do |t|
      t.string :name
      t.integer :result_id

      t.timestamps
    end
  end
end
