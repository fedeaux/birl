class AddMetaToDay < ActiveRecord::Migration[5.2]
  def change
    add_column :days, :meta, :jsonb, default: {}
  end
end
