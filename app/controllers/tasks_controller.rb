class TasksController < ApplicationController
  before_filter :find_user, :only => [:index]

  def index
    @tasks = @user.tasks.order('rank DESC')
  end

  def create
    create! { new_task_path }
  end

  def update
    update! { tasks_path }
  end

  private

  def find_user
    @user = current_user
    redirect_to root_path if @user.nil?
  end
end
