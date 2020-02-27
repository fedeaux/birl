class AddDayToTimelog < ActiveRecord::Migration[5.2]
  def change
    add_reference :timelogs, :day, foreign_key: true
  end
end
