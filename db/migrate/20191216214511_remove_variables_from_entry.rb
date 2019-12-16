class RemoveVariablesFromEntry < ActiveRecord::Migration[5.2]
  def change
    remove_column :entries, :variables
  end
end
