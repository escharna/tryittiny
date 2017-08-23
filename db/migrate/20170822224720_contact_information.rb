class ContactInformation < ActiveRecord::Migration[5.1]
  def change
    create_table :contact_informations do |t|
      t.string :name
      t.integer :result_id

      t.timestamps
    end
  end
end
