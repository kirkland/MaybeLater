class AddStatusToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :status, :string, :limit => 32, :nil => false, :default => 'open'
  end

  def self.down
    remove_column :tasks, :status
  end
end
