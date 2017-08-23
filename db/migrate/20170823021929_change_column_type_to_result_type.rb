class ChangeColumnTypeToResultType < ActiveRecord::Migration[5.1]
  def change
    rename_column :results, :type, :result_type
  end
end
