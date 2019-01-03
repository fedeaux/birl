class CreateProgressions < ActiveRecord::Migration[5.2]
  def change
    create_table :progressions do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.references :challenge, foreign_key: true
      t.references :exercise, foreign_key: true

      t.timestamps
    end
  end
end
