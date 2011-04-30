class User < ActiveRecord::Base
  acts_as_authentic

  serialize :task_ids

  # the task model has no concept of a rank, so we need to set
  # it as we retrieve them.
  def tasks
    Task.where(:id => task_ids).enum_with_index.collect{|t, i| t.rank = i; t}
  end
end
