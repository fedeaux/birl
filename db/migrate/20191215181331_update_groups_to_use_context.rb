class UpdateGroupsToUseContext < ActiveRecord::Migration[5.2]
  def change
    add_reference :groups, :context, index: true
    remove_column :groups, :user_id
  end
end
