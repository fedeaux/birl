class CreateDays < ActiveRecord::Migration[5.2]
  def change
    create_table :days do |t|
      t.belongs_to :user, foreign_key: true
      t.string :stamp
      t.boolean :planned

      t.timestamps
    end
  end
end
