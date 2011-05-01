class User < ActiveRecord::Base
  acts_as_authentic
  has_many :tasks
  serialize :ordered_task_ids

  def ordered_tasks
    ordered_task_ids.collect{|x| Task.find(x)}
  end

  def set_ordered_task_ids(input_ordered_task_ids)
    self.ordered_task_ids = input_ordered_task_ids
    save!
  end
end
