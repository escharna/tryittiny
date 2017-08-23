class ChangeResultsDecimalsToStrings < ActiveRecord::Migration[5.1]
  def change
    change_column :results, :bedrooms, :string
    change_column :results, :bathrooms, :string
    change_column :results, :garage, :string
    change_column :results, :lot_size, :string
    change_column :results, :square_feet, :string
  end
end
