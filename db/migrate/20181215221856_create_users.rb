class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :role, default: 0
      t.boolean :enabled, default: true
      t.string :address
      t.string :city
      t.integer :zip
      t.string :state

      t.timestamps
    end
  end
end
