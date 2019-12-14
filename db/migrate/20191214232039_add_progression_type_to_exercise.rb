class AddProgressionTypeToExercise < ActiveRecord::Migration[5.2]
  def change
    add_column :exercises, :progression_type, :string
  end
end
