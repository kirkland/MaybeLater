class TasksController < ApplicationController
  before_filter :find_user, :only => [:index, :reorder, :create]

  def index
    @task = Task.new
    @tasks = @user.ordered_tasks
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

  def find_user
    @user = current_user
    redirect_to login_path if @user.nil?
  end
end
