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

  def update_rank
    t = Task.find(params[:id])
    t.rank = params[:new_rank].to_i == -1 ? Task.order('rank DESC').first.rank + 1 : params[:new_rank].to_i
    t.save
    render :json => {:task_id => t.id, :task_rank => t.rank}
  end

  private

  def find_user
    @user = current_user
    redirect_to login_path if @user.nil?
  end
end
