class AddTitleToTasks < ActiveRecord::Migration
  def self.up
    rename_column :tasks, :content, :title
    add_column :tasks, :content, :text
  end

  def self.down
    remove_column :tasks, :content
    rename_column :tasks, :title, :content
  end
end
