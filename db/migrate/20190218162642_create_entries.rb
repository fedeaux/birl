class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.string :name
      t.references :progression, foreign_key: true
      t.string :values
      t.string :variables
      t.text :observations

      t.timestamps
    end
  end
end
