class AddNameToDay < ActiveRecord::Migration[5.2]
  def change
    add_column :days, :name, :string
  end
end
