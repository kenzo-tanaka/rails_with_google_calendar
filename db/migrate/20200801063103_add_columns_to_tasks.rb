class AddColumnsToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :start_date, :datetime
    add_column :tasks, :end_date, :datetime
    add_column :tasks, :event, :string
    add_column :tasks, :members, :string
  end
end
