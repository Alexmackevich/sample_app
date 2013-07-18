class SessionsController < ApplicationController
 
 def new
 end

 def create
 	 user = User.find_by_email(params[:session][:email].downcase)
  if user && user.authenticate(params[:session][:password])
    sign_in user    # vpuskaem pol'zovatelia
    redirect_back_or user # redirectim na stranicu usera
  else
     flash.now[:error] = 'Invalid email or password' # poiavlenie flash soobshenia o nepravil'nom vhode
      render 'new'
  end
 end

 def destroy
    sign_out
    redirect_to root_url
  end
end
