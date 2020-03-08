class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.string :name
      t.string :type
      t.belongs_to :user, foreign_key: true
      t.jsonb :meta, default: {}
      t.jsonb :recurrence_scheme

      t.timestamps
    end
  end
end
