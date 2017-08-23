class PhoneNumber < ActiveRecord::Migration[5.1]
  def change
    create_table :phone_numbers do |t|
      t.string :number
      t.integer :contact_information_id

      t.timestamps
    end
  end
end
