class AuthController < ApplicationController
  before_action :set_user, only: [:login]
  skip_before_action :authorized, only: [:login]

  def login
    if @user && @user.authenticate(auth_params[:password])
      @token = encode_token(user_id: @user.id)
      render json: { user: @user, jwt: @token }, status: :created
    else
      render json: { error: "Incorrect username or password" }
    end
  end
end

private

# Use callbacks to share common setup or constraints between actions.
def set_user
  @user = User.find_by(user_name: auth_params[:user_name])
end

def auth_params
  params.require(:auth).permit(:user_name, :password)
end
