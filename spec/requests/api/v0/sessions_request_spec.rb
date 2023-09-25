require "rails_helper"

RSpec.describe Api::V0::SessionsController, type: :controller do
  describe "POST #create" do
    context "with valid credentials" do
      let(:user) { create(:user, email: "valid@example.com", password: "password") }
      let(:valid_credentials) { { user: { email: user.email, password: "password" } } }

      it "returns a success response" do
        post :create, params: valid_credentials
        expect(response).to have_http_status(:ok)
      end

      it "returns the user data" do
        post :create, params: valid_credentials

        expect(JSON.parse(response.body)["data"]).to have_key("id")
        expect(JSON.parse(response.body)["data"]["type"]).to eq("users")
        expect(JSON.parse(response.body)["data"]["attributes"]["email"]).to eq("valid@example.com")
        expect(JSON.parse(response.body)["data"]["attributes"]).to have_key("api_key")
      end
    end

    context "with invalid credentials" do
      let(:invalid_credentials) { { user: { email: "invalid@example.com", password: "wrong_password" } } }

      it "returns an unprocessable entity response" do
        post :create, params: invalid_credentials
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns an error message" do
        post :create, params: invalid_credentials
        expect(JSON.parse(response.body)["errors"]).to include("Invalid email or password")
      end
    end
  end
end
