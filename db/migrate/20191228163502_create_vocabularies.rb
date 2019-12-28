class CreateVocabularies < ActiveRecord::Migration[5.2]
  def change
    create_table :vocabularies do |t|
      t.string :es
      t.string :pt_br
      t.string :en
      t.string :comment
      t.string :kind
      t.jsonb :meta

      t.timestamps
    end
  end
end
