class AuthenticationController < ApplicationController
  # CSRF対策を無効にする
  protect_from_forgery except: :authenticate
  
  def authenticate
    user = User.find_by(token: authentication_params[:token])
    if user
      session[:user_id] = user.id
      render json: { 'message': 'Authentication success' }, status: :ok
    else
      render json: { 'message': 'Authentication failure' }, status: :unauthorized
    end
  end

  private

  def authentication_params
    params.require(:authentication).permit(:token)
  end
end
