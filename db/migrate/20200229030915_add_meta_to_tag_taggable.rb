class AddMetaToTagTaggable < ActiveRecord::Migration[5.2]
  def up
    add_column :tag_taggables, :meta, :jsonb, default: {}

    TagTaggable.where(taggable_type: 'Timelog').update_all(meta: { main: true })
  end

  def down
    remove_column :tag_taggables, :meta, :jsonb, default: {}
  end
end
