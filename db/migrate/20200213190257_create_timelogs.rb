class CreateTimelogs < ActiveRecord::Migration[5.2]
  def change
    create_table :timelogs do |t|
      t.datetime :start
      t.datetime :finish
      t.text :description
      t.jsonb :meta
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
