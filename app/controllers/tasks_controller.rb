class TasksController < ApplicationController
  before_filter :find_user_and_tasks, :only => [:index, :update_rank]

  def create
    create! { new_task_path }
  end

  def update
    update! { tasks_path }
  end

  def update_rank
    Task.find(params[:id].to_i).update_rank(params[:new_rank].to_i, @user)
    render :nothing => true
  end

  private

  def find_user_and_tasks
    @user = current_user
    @tasks = @user.tasks
    redirect_to login_path if @user.nil?
  end
end
