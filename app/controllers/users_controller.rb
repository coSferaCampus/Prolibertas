class UsersController < ApplicationController
  respond_to :json
  load_and_authorize_resource param_method: :user_params

  def show
    respond_with @user
  end

  def index
    @users = User.all
    respond_with @users
  end

  def create
    @user = User.create(user_params)
    respond_with @user
  end

  def update
    @user.update_attributes(user_params)
    respond_with @user
  end

  def destroy
    @user.destroy
    respond_with @user
  end

  private

  def user_params
    params.require(:user).permit(:id, :name, :full_name, :email, :tlf)
  end
end
