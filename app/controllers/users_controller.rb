class UsersController < ApplicationController
  respond_to :json
  load_and_authorize_resource param_method: :user_params

  def show
    respond_with @user
  end

  def index
    @users = 
      if current_user.has_role? :director
        User.with_any_role(:volunteer, :worker)
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

    if @user == current_user
      sign_in @user, bypass: true
    end

    respond_with @user
  end

  def destroy
    @user.destroy 
    respond_with @user
  end

  private

  def user_params
    params.require(:user).permit(:id, :name, :full_name, :email, :tlf, :password, :password_confirmation)
  end
end
