class UpdateChallengesToUseContext < ActiveRecord::Migration[5.2]
  def change
    add_reference :challenges, :context, index: true
    remove_column :challenges, :user_id
  end
end
