class Api::V0::SessionsController < ApplicationController

  def create
    @user = User.find_by(params[:email])
    if @user&.authenticate(params[:user][:password])
      render_user_data(@user)
    else
      render_invalid_credentials
    end
  end

  private

  def render_user_data(user)
    render json: {
        data: {
          type: "users",
          id: user.id,
          attributes: {
            email: user.email,
            api_key: user.api_key
          }
        }
      }, status: :ok
  end

  def render_invalid_credentials
    render json: {
      errors: ["Invalid email or password"]
    }, status: :unprocessable_entity
  end
end