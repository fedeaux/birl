class AddWeekdayToSession < ActiveRecord::Migration[5.2]
  def change
    add_column :sessions, :weekday, :integer
  end
end
