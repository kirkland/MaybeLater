class User < ActiveRecord::Base
  acts_as_authentic

  serialize :task_ids

  def tasks
    task_ids.collect{|x| Task.find(x)}
  end
end
