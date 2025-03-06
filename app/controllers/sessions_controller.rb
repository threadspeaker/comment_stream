class SessionsController < ApplicationController
  def new
  end

  def create
    # Find or create a user with the given name
    user = User.find_or_create_by(name: params[:name])
    
    # Store the user ID in the session
    session[:user_id] = user.id
    
    # Redirect to posts list
    redirect_to posts_path, notice: "Welcome, #{user.name}!"
  end

  def destroy
    # Clear the session (eg. logout)
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out successfully!"
  end
end
