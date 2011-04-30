class Task < ActiveRecord::Base
  after_save :update_ranks

  def update_ranks
    if rank.present? && rank_changed? && user.tasks.find_by_rank(rank).present?
      Task.where("id != ?", id).where("rank >= ?", rank).update_all("rank = rank + 1")
    end
  end
  
  # probably slow, probably not used
  def user
    User.all.detect{|u| u.task_ids.include?(id)}
  end
end
