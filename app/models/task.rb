class Task < ActiveRecord::Base
  belongs_to :user

  after_create :update_user_ordered_task_ids

  def update_user_ordered_task_ids
    user.update_attribute(:ordered_task_ids, user.ordered_task_ids.unshift(id))
  end

  def update_status(defer_time)
    if defer_time == 0 # magic number which means task completed
      self.status = 'completed'
      self.completed_at = Time.now
    else
      self.status = 'deferred'
      self.remind_at = Time.now + defer_time
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
      ordered_active(user) + ordered_deferred + ordered_completed
    end

    def ordered_active(user)
      user.ordered_task_ids.collect{|x| Task.find(x)}.select{|x| x.status == 'active'}
    end

    def ordered_deferred
      deferred.order('remind_at DESC')
    end

    def ordered_completed
      completed.order('completed_at DESC')
    end
  end
end
