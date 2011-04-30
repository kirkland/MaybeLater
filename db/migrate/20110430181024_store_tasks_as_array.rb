class StoreTasksAsArray < ActiveRecord::Migration
  # warning: this is destructive... you will lose all associations between users and tasks when you run this.
  # i'm just too lazy to not do it this way
  def self.up
    add_column :users, :tasks, :text, :default => []
    remove_column :tasks, :user_id
  end

  def self.down
    add_column :tasks, :user_id
    remove_column :users, :tasks
  end
end
