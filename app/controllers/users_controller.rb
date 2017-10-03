class UsersController < ApplicationController
  def show
    @user_bookmarks = current_user.bookmarks
    @liked_bookmarks = current_user.liked_bookmarks
  end
  
  def index
    if current_user.present?
      
      @users = User.all
    else
      redirect_to new_user_registration_path
    
    end
  end
end
