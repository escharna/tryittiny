class AddSourceToQueries < ActiveRecord::Migration[5.1]
  def change
    add_column :queries, :source, :string
  end
end
