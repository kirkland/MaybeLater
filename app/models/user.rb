class User < ActiveRecord::Base
  acts_as_authentic
  has_many :tasks
  serialize :ordered_task_ids

  def set_ordered_task_ids(input_ordered_task_ids)
    self.ordered_task_ids = input_ordered_task_ids
    save!
  end

  def after_create
    self.update_attribute(:ordered_task_ids, [])
  end
end
