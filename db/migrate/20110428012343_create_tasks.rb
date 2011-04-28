class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :content, :limit => 256
      t.integer :rank
      t.integer :user_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
