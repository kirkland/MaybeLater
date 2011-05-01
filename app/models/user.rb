class User < ActiveRecord::Base
  acts_as_authentic
  has_many :tasks

  serialize :task_ids

  def ordered_tasks
    task_ids.collect{|x| Task.find(x)}
  end
end
