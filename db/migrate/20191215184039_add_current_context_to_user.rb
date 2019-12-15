class AddCurrentContextToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :current_context, foreign_key: { to_table: :contexts }
  end
end
