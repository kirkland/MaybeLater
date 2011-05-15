class TasksController < ApplicationController
  before_filter :find_user, :only => [:index, :reorder, :create, :update_status]

  def index
    @task = Task.new
    @tasks = @user.tasks.ordered(@user)
  end

  def create
    t = Task.create!(params[:task].merge(:user => @user))
    render :json => t
  end

  def update
    update! { tasks_path }
  end

  def reorder
    @user.set_ordered_task_ids(params[:ordered_task_ids].map(&:to_i))
    render :text => @user.ordered_task_ids.inspect
  end

  def update_status
    task = @user.tasks.find(params[:task_id].to_i)
    task.update_status(params[:defer_time].to_i)
    render :text => params.inspect and return
#    render :json => task
  end

  private

  def find_user
    @user = current_user
    redirect_to login_path if @user.nil?
  end
end
