class AddRecurrenceSchemeToSession < ActiveRecord::Migration[5.2]
  def change
    add_column :sessions, :recurrence_scheme, :jsonb
  end
end
