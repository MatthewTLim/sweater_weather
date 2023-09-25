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

    it "returns the required info" do
      get :search, params: { location: @location_details, quantity: 5 }

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to be_a(Hash)
      expect(response_body).to have_key(:data)
      expect(response_body[:data]).to have_key(:id)
      expect(response_body[:data]).to have_key(:type)
      expect(response_body[:data]).to have_key(:attributes)
      expect(response_body[:data][:attributes]).to have_key(:destination)
      expect(response_body[:data][:attributes]).to have_key(:forecast)
      expect(response_body[:data][:attributes][:forecast]).to have_key(:summary)
      expect(response_body[:data][:attributes][:forecast]).to have_key(:temperature)
      expect(response_body[:data][:attributes]).to have_key(:total_books_found)
      expect(response_body[:data][:attributes]).to have_key(:books)
      expect(response_body[:data][:attributes][:books]).to be_an(Array)
      expect(response_body[:data][:attributes][:books][0]).to have_key(:title)
      expect(response_body[:data][:attributes][:books][0]).to have_key(:isbn)
      expect(response_body[:data][:attributes][:books].count).to eq(5)
    end
  end
end