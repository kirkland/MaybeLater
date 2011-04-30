class Task < ActiveRecord::Base
  attr_accessor :rank

  # optionally pass in user from controller since we already know it,
  # and don't want to bother with slow user method in this class
  def update_rank(new_rank, user=nil)
    user = self.user if user.nil?
    
    if new_rank == -1
      user.tasks << self
    else
      user.task_ids.insert(new_rank, id) # TODO: insert the Task model in to the tasks array (which will automatically update task_ids)
    end
    user.save!
  end
  
  # probably slow, probably not used
  def user
    User.all.detect{|u| u.task_ids.include?(id)}
  end
end
