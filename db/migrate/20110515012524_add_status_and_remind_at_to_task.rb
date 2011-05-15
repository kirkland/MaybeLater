class AddStatusAndRemindAtToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :status, :string, :limit => 32, :nil => false, :default => 'active'
    add_column :tasks, :remind_at, :datetime
  end

  def self.down
    remove_column :tasks, :status
    remove_column :tasks, :remind_at
  end
end
