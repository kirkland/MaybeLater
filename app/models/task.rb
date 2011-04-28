class Task < ActiveRecord::Base
  belongs_to :user
  after_save :update_ranks

  def update_ranks
    if rank.present? && rank_changed?
      Task.where("id != ?", id).where("rank >= ?", rank).update_all("rank = rank + 1")
    end
  end
end
