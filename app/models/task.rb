class Task < ActiveRecord::Base
  belongs_to :user

  after_create :update_user_ordered_task_ids

  def update_user_ordered_task_ids
    user.update_attribute(:ordered_task_ids, user.ordered_task_ids.unshift(id))
  end

  def update_status(defer_days)
    if defer_days == 0 # magic number which means task completed
      self.status = 'completed'
      self.completed_at = Time.now
    else
      self.status = 'deferred'
      self.remind_at = Time.now + defer_days.days
    end

    save!
  end

  def reactivate!
    self.status = 'active'
    self.remind_at = nil
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
      ordered_active(user)# + ordered_deferred + ordered_completed
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

    def reset_old_deferred_tasks
      Task.where(:status => 'deferred').where(:remind_at.lt => Time.now).update_all(["status = ?, remind_at = ?", 'active', nil])
    end
  end
end
