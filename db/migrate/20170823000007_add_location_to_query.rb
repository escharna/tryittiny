class AddLocationToQuery < ActiveRecord::Migration[5.1]
  def change
    add_column :queries, :location, :string
  end
end
