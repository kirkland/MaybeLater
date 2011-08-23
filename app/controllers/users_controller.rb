class UsersController < ApplicationController
  before_filter :find_user

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Registration successful."  
      redirect_to root_url  
    else  
      flash[:error] = @user.errors
      render :action => 'new'  
    end  
  end

  def automatic_create
    random_password = random_string
    @user = User.new({:password => random_password, :password_confirmation => random_password, :username => random_string, :email => "#{random_string}@example.com"})
    sign_in(@user)
    redirect_to root_path
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated profile."
      redirect_to root_url
    else
      flash[:error] = @user.errors
      render :action => 'edit'
    end
  end

  private

  def find_user
    @user = current_user
  end

  def random_string
    (0...8).map{97.+(rand(25)).chr}.join
  end
end
