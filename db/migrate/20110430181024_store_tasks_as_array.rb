class StoreTasksAsArray < ActiveRecord::Migration
  # warning: this is destructive... you will lose all associations between users and tasks when you run this.
  # i'm just too lazy to not do it this way
  def self.up
    add_column :users, :ordered_task_ids, :text, :default => []
    remove_column :tasks, :rank
  end

  def self.down
    add_column :tasks, :rank, :integer
    remove_column :users, :ordered_task_ids
  end
end
