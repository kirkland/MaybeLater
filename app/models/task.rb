class Task < ActiveRecord::Base
  belongs_to :user

  after_create :update_user_ordered_task_ids

  def update_user_ordered_task_ids
    user.update_attribute(:ordered_task_ids, user.ordered_task_ids.unshift(id))
  end

  def update_status(defer_time)
    if defer_time == 0 # magic number which means task completed
      self.status = 'completed'
    else
      self.status = 'deferred'
#      self.remind_at = Time.now + defer_time
    end

    save!
  end

  class << self
    def completed
      where(:status => 'complete')
    end

    def deferred
      where(:status => 'deferred')
    end

    def active
      where(:status => 'active')
    end

    def ordered(user)
      where(:id => user.ordered_task_ids).collect{|x| Task.find(x)}
    end
  end
end
