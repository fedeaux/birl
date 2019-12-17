class RemoveProgressionTypeFromExercise < ActiveRecord::Migration[5.2]
  def change
    remove_column :exercises, :progression_type
  end
end
