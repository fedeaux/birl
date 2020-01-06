class CreateMemes < ActiveRecord::Migration[5.2]
  def change
    create_table :memes do |t|
      t.string :type
      t.datetime :done_at
      t.belongs_to :user, foreign_key: true
      t.jsonb :contents, default: {}

      t.timestamps
    end
  end
end
