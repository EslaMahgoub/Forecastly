class UsersController < ApplicationController
  before_action :set_user,       only: %i[ show edit update destroy correct_user]
  before_action :logged_in_user, only: %i[ index edit update destroy ]
  before_action :correct_user,   only: %i[ edit update destroy ]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        log_in @user 
        format.html { redirect_to @user, notice: "Welcome To Forecastly." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to root_path, notice: "User was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to login_path, notice: "Account was successfully deleted." }
    end
  end


  private
    def set_user
      @user = User.friendly.find(params[:id])
    end

    def correct_user
      redirect_to(root_path) unless current_user.present? && current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.present? && current_user.admin?
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :country, :admin)
    end
end
