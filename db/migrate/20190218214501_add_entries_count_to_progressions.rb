class AddEntriesCountToProgressions < ActiveRecord::Migration[5.2]
  def change
    add_column :progressions, :entries_count, :integer
  end
end
