class AddOverrideEntryDataModelToProgression < ActiveRecord::Migration[5.2]
  def change
    add_column :progressions, :override_entry_data_model, :jsonb, default: {}
  end
end
