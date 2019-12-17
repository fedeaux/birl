class AddEntryDataModelToChallenge < ActiveRecord::Migration[5.2]
  def change
    add_column :challenges, :entry_data_model, :jsonb, default: {}
  end
end
