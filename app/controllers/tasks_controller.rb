class TasksController < ApplicationController
  before_filter :find_or_create_user, :only => [:index, :reorder, :create, :update_status]

  def index
    @task = Task.new
    @tasks = @user.tasks.ordered(@user)
  end

  def create
    t = Task.create!(params[:task].merge(:user => @user))
    render :json => {:task => t.attributes.merge(:update_path => update_status_task_path(t))}
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
    task.update_status(params[:defer_days].to_i)
    render :text => params.inspect and return
  end

  private

  def find_or_create_user
    @user = current_user
    if @user.nil?
      random_password = random_string
      redirect_to 'users#create', params => {:user => {:password => random_password, :password_confirmation => random_password, :username => random_string, :email => "#{random_string}@example.com"}}
    end
  end

  def random_string
    (0...8).map{97.+(rand(25)).chr}.join
  end
end
