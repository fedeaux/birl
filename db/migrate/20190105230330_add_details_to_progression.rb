class AddDetailsToProgression < ActiveRecord::Migration[5.2]
  def change
    add_column :progressions, :details, :string
  end
end
