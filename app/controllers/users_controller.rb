class UsersController < ApplicationController
  respond_to :json
  load_and_authorize_resource param_method: :user_params

  def show
    respond_with @user
  end

  def index
    @users = 
      if current_user.has_role? :director
        User.all
      elsif current_user.has_role? :worker
        User.with_role :volunteer
      end

    respond_with @users
  end

  def create
    rol = params[:user].delete :role
    @user = User.new(user_params)

    if current_user.has_role? :director
      @user.add_role(rol)
    elsif current_user.has_role? :worker
      @user.add_role "volunteer"
    end

    @user.save

    respond_with @user
  end

  def update
    rol = params[:user].delete :role

    @user.update_attributes(user_params)

    if current_user.has_role? :director
      @user.add_role(rol)
    end

    respond_with @user
  end

  def destroy
    rol = params[:user].delete :role
    @user.destroy unless current_user.has_role? :worker and (rol == "worker" or rol == "director")
    respond_with @user
  end

  private

  def user_params
    params.require(:user).permit(:id, :name, :full_name, :email, :tlf, :password, :password_confirmation)
  end
end
