class ApplicationController < ActionController::Base
  def logged_in
    user_id = session[:user_id]
    return redirect_to login_path if user_id.blank?

    @user = User.find_by id: user_id
    redirect_to logged_in if @user.nil?
  end

  def logged_in?
    !session[:user_id].nil?
  end
end
