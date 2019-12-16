class ChangeEntryValueToJsonb < ActiveRecord::Migration[5.2]
  def change
    add_column :entries, :value, :jsonb, default: {}
  end
end
