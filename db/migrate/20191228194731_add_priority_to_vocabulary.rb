class AddPriorityToVocabulary < ActiveRecord::Migration[5.2]
  def change
    add_column :vocabularies, :priority, :integer, default: 1 # medium
  end
end
