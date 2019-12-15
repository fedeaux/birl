class UpdateExercisesToUseContext < ActiveRecord::Migration[5.2]
  def change
    add_reference :exercises, :context, index: true
    remove_column :exercises, :user_id
  end
end
