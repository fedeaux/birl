class CreateSessionProgressions < ActiveRecord::Migration[5.2]
  def change
    create_table :session_progressions do |t|
      t.belongs_to :session, foreign_key: true
      t.belongs_to :progression, foreign_key: true
      t.integer :order

      t.timestamps
    end
  end
end
