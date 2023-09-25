require "rails_helper"

RSpec.describe Api::V0::UsersController, type: :controller do
  describe "POST #create" do
    context "with valid user params" do
      let(:valid_user_params) do
        {
          user: {
            email: "test@example.com",
            password: "password",
            password_confirmation: "password"
          }
        }
      end

      it "creates a new user" do
        expect do
          post :create, params: valid_user_params
        end.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)

        user = User.last
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["data"]["attributes"]["email"]).to eq(user.email)
        expect(parsed_response["data"]["attributes"]["api_key"]).to eq(user.api_key)
      end
    end

    context "with invalid user params" do
      let(:invalid_user_params) do
        {
          user: {
            email: "invalid-email",
            password: "password",
            password_confirmation: "wrong_password"
          }
        }
      end

      it "does not create a new user" do
        expect do
          post :create, params: invalid_user_params
        end.to_not change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)

        parsed_response = JSON.parse(response.body)
        expect(parsed_response["errors"]).to be_an(Array)
        expect(parsed_response["errors"]).to include("Email is invalid", "Password confirmation doesn't match Password")
      end
    end
  end
end
