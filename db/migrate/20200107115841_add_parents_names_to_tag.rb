class AddParentsNamesToTag < ActiveRecord::Migration[5.2]
  def change
    add_column :tags, :parents_names, :jsonb, default: []
    add_column :tags, :fullname, :string
  end
end
