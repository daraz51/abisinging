class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:edit, :update, :index, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy
  before_filter :signed_out_user, only: [:new, :create]

  def destroy
    user = User.find(params[:id])
    if current_user?(user) && current_user.admin?
      redirect_to root_url
    else
      user.destroy
      flash[:success] = "User destroyed."
      redirect_to users_url
    end
  end

  def new
  		@user = User.new
  end

  def show
  		@user = User.find(params[:id])
  end

  def create
  		@user = User.new(params[:user])
  		if @user.save
        sign_in @user
  			flash[:success] = "Welcome to Sample App!"
  			redirect_to @user
  		else
  			render 'new'
  		end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def signed_out_user
      unless current_user.nil?
        redirect_to root_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end