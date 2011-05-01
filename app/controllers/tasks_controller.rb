class TasksController < ApplicationController
  before_filter :find_user, :only => [:index, :reorder]

  def index
    @tasks = @user.ordered_tasks
  end

  def create
    create! { new_task_path }
  end

  def update
    update! { tasks_path }
  end

  def reorder
    @user.set_ordered_task_ids(params[:ordered_task_ids].map(&:to_i))
    render :text => @user.ordered_task_ids.inspect
  end

  private

  def find_user
    @user = current_user
    redirect_to login_path if @user.nil?
  end
end
