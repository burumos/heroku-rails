class SessionsController < ApplicationController
  def new
    redirect_to root_path if logged_in?
  end

  def create
    user = User.find_by(login_id: login_param[:login_id])
    unless user&.authenticate(login_param[:password])
      flash.now[:danger] = 'ログイン失敗'
      render 'new'
      return
      # return redirect_to login_path, flash: { danger: 'ログイン失敗' } 
    end

    log_in user
    redirect_to root_path
  end

  def destroy
    logout
    redirect_to login_path
  end

  private

  def login_param
    params.require(:session).permit(:login_id, :password)
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def logout
    session.delete(:user_id)
  end
end
