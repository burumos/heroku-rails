class SessionsController < ApplicationController
  def new
    redirect_to root_path if logged_in?
  end

  def create
    totp_id = params[:id]
    pass = params[:totp]

    return redirect_to login_path, flash: { message: 'ログイン失敗' } unless try_login totp_id, pass

    user = insert_user_if_not_exist totp_id
    session[:user_id] = user.id

    redirect_to root_path
  end

  def destroy
    logout
    redirect_to login_path
  end

  private

  def try_login(totp_id, pass)
    totp_key = ENV["totp_#{totp_id}"]
    return false if totp_key.blank?

    if ROTP::TOTP.new(totp_key).verify(pass).nil?
      flash[:id] = totp_id
      return false
    end
    true
  end

  def insert_user_if_not_exist(totp_id)
    user = User.find_by totp_id: totp_id
    if user.nil?
      user = User.new totp_id: totp_id
      user.save
    end
    user
  end

  def logout
    session.delete(:user_id)
  end
end
