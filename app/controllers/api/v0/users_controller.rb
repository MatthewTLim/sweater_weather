class Api::V0::UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      render json: {
        data: {
          type: "users",
          id: user.id,
          attributes: {
            email: user.email,
            api_key: user.api_key
          }
        }
      }, status: :created
    else
      render json: {
        errors: user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
