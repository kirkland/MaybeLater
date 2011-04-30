class User < ActiveRecord::Base
  acts_as_authentic

  serialize :task_ids

  def tasks
    Task.where(:id => task_ids)
  end
end
