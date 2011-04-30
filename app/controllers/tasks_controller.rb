class TasksController < ApplicationController
  before_filter :find_user_and_tasks, :only => [:index, :update_rank]

  def create
    create! { new_task_path }
  end

  def update
    update! { tasks_path }
  end

  def update_rank
    @user.update_attribute(:task_ids, params[:task_ids].map(&:to_i))
    render :text => @user.task_ids.inspect
  end

  private

  def find_user_and_tasks
    @user = current_user
    @tasks = @user.tasks
    redirect_to login_path if @user.nil?
  end
end
