class AddExecutedAtToSession < ActiveRecord::Migration[5.2]
  def change
    add_column :sessions, :executed_at, :datetime
  end
end
