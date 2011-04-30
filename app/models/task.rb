class Task < ActiveRecord::Base
  # probably slow, probably not used
  def user
    User.all.detect{|u| u.task_ids.include?(id)}
  end
end
