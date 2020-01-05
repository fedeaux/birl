class MakeTagColorsJsons < ActiveRecord::Migration[5.2]
  def change
    remove_column :tags, :color, :string
    remove_column :tags, :background_color, :string

    add_column :tags, :color, :jsonb, default: {}
    add_column :tags, :background_color, :jsonb, default: {}
  end
end
