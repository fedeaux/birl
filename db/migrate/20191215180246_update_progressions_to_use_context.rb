class UpdateProgressionsToUseContext < ActiveRecord::Migration[5.2]
  def change
    add_reference :progressions, :context, index: true
    remove_column :progressions, :user_id
  end
end
