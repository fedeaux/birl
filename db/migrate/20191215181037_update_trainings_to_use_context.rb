class UpdateTrainingsToUseContext < ActiveRecord::Migration[5.2]
  def change
    add_reference :trainings, :context, index: true
    remove_column :trainings, :user_id
  end
end
