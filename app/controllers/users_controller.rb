class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user,   only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  end
  
  def new
  	@user = User.new
  end

  def create # process registracii
    @user = User.new(params[:user]) # zapolnenie parametrov dlia usera
    if @user.save
      sign_in @user # posle registracii srazu na str pol'zovatelia
      flash[:success] = "Welcome to MTwitter!" # flash-soobshenie ob uspeshnoi registracii
      redirect_to @user   # redirectit na stranicu usera
    else
      render 'new'
    end
  end

   def index
    @users = User.paginate(page: params[:page])
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

  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
