class ChangeResultsPriceDecimalToString < ActiveRecord::Migration[5.1]
  def change
    change_column :results, :price, :string
  end
end
