class CreateEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :emails do |t|
      t.string :subject
      t.datetime :date
      t.string :from
      t.string :to
      t.text :body
      t.string :verification_link

      t.timestamps
    end
  end
end
