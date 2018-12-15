class CreateOrder < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :status
      t.references :users, foreign_key: true
    end
  end
end
