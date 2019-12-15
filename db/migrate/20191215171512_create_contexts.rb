class CreateContexts < ActiveRecord::Migration[5.2]
  def change
    create_table :contexts do |t|
      t.string :name
      t.string :color
      t.string :slug
      t.belongs_to :user, foreign_key: true
      t.jsonb :meta

      t.timestamps
    end
  end
end
