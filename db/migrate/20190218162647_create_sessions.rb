class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.string :name
      t.belongs_to :training, foreign_key: true

      t.timestamps
    end
  end
end
