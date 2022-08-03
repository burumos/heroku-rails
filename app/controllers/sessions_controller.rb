class SessionsController < ApplicationController
  def new
  end

  def create
    id = params[:id]
    totp_key = ENV["totp_#{id}"]
    if id.blank? || totp_key.blank? then
      return redirect_to login_path, flash: { message: "idが不正" }
    end
    totp_pass = params[:totp]
    Rails.logger.debug "----- id: #{id}, key: #{totp_key}, password: #{totp_pass}"
    if totp_pass.blank? || ROTP::TOTP.new(totp_key).verify(totp_pass).nil? then
      flash[:id] = id
      return redirect_to login_path, flash: { message: "totpが不正" }
    end

    redirect_to login_path, flash: { message: "認証しました id:#{params[:id]}, totp: #{params[:totp]}" }
  end

  def destroy
  end
end
