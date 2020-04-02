class CreateWeeks < ActiveRecord::Migration[5.2]
  def change
    create_table :weeks do |t|
      t.string :name
      t.string :stamp
      t.belongs_to :user, foreign_key: true
      t.jsonb :meta, default: {}

      t.timestamps
    end
  end
end
