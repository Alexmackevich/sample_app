class UsersController < ApplicationController
  
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
      flash[:success] = "Welcome to the Sample App!" # flas-soobshenie ob uspeshnoi registracii
      redirect_to @user   # redirectit na stranicu usera
    else
      render 'new'
    end
  end
end
