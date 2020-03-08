class CreateGoalEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :goal_entries do |t|
      t.string :name
      t.belongs_to :goal, foreign_key: true
      t.datetime :start
      t.datetime :finish
      t.jsonb :meta, default: {}

      t.timestamps
    end
  end
end
