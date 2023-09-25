require "rails_helper"

RSpec.describe Api::V0::BookSearchController, type: :controller do
  describe "#class_methods" do
    before do
      @location_details = "Denver,CO"
    end

    it "returns a successful response" do
      get :search, params: { location: @location_details, quantity: 5 }

      expect(response).to have_http_status(:success)
    end
  end
end