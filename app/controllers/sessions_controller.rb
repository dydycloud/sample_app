class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	if user && user.authenticate(params[:password])
  		# Sign the user in and redirect to the user's show page.
  		sign_in user
  		redirect_back_or user
    else
    	# Create an error message and re-render the signin form.
    	flash.now[:error] = 'Invalid email/password combination'#not quite right!
    	render 'new'
  	end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
