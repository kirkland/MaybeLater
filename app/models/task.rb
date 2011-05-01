class Task < ActiveRecord::Base
  belongs_to :user

  after_create :update_user_ordered_task_ids

  def update_user_ordered_task_ids
    user.update_attribute(:ordered_task_ids, user.ordered_task_ids.unshift(id))
  end
end
