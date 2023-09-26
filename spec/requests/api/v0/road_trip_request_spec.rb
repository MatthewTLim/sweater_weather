require "rails_helper"

RSpec.describe Api::V0::RoadTripController, type: :controller do
  describe "#class_methods" do
    let!(:user) do
      User.create(email: "valid@example.com", password: "password", password_confirmation: "password")
    end

    let(:valid_credentials) { { user: { email: user.email, password: "password" } } }

    it "returns a successful response NYC,NY" do
      VCR.use_cassette("road_trip_controller_1") do
        post :create, params: { origin: "NYC,NY",
                                destination: "LA,CA",
                                api_key: user.api_key
                              }

        expect(response).to have_http_status(200)

        parsed_response = JSON.parse(response.body)

        expect(parsed_response).to have_key("data")
        expect(parsed_response["data"]).to have_key("id")
        expect(parsed_response["data"]).to have_key("type")
        expect(parsed_response["data"]).to have_key("attributes")
        expect(parsed_response["data"]["attributes"]["start_city"]).to eq("NYC,NY")
        expect(parsed_response["data"]["attributes"]["end_city"]).to eq("LA,CA")
        expect(parsed_response["data"]["attributes"]["travel_time"]).to eq("39:26:34")
        expect(parsed_response["data"]["attributes"]["weather_at_eta"]).to have_key("datetime")
        expect(parsed_response["data"]["attributes"]["weather_at_eta"]).to have_key("temperature")
        expect(parsed_response["data"]["attributes"]["weather_at_eta"]).to have_key("condition")
        expect(parsed_response["data"]["attributes"]["weather_at_eta"]["datetime"]).to eq("2023-09-28")
        expect(parsed_response["data"]["attributes"]["weather_at_eta"]["temperature"]).to eq(83.4)
        expect(parsed_response["data"]["attributes"]["weather_at_eta"]["condition"]).to eq("Moderate rain")
      end
    end

    it "returns a successful response Panama City, Panama" do
      VCR.use_cassette("road_trip_controller_2") do
        post :create, params: { origin: "NYC,NY",
                                destination: "Panama City, Panama",
                                api_key: user.api_key
                              }

        expect(response).to have_http_status(200)

        parsed_response = JSON.parse(response.body)

        expect(parsed_response).to have_key("data")
        expect(parsed_response["data"]).to have_key("id")
        expect(parsed_response["data"]).to have_key("type")
        expect(parsed_response["data"]).to have_key("attributes")
        expect(parsed_response["data"]["attributes"]["start_city"]).to eq("NYC,NY")
        expect(parsed_response["data"]["attributes"]["end_city"]).to eq("Panama City, Panama")
        expect(parsed_response["data"]["attributes"]["travel_time"]).to eq("75:42:12")
        expect(parsed_response["data"]["attributes"]["weather_at_eta"]).to have_key("datetime")
        expect(parsed_response["data"]["attributes"]["weather_at_eta"]).to have_key("temperature")
        expect(parsed_response["data"]["attributes"]["weather_at_eta"]).to have_key("condition")
        expect(parsed_response["data"]["attributes"]["weather_at_eta"]["datetime"]).to eq("2023-09-29")
        expect(parsed_response["data"]["attributes"]["weather_at_eta"]["temperature"]).to eq(84.8)
        expect(parsed_response["data"]["attributes"]["weather_at_eta"]["condition"]).to eq("Patchy rain possible")
      end
    end

    it "returns a successful response London, UK" do
      VCR.use_cassette("road_trip_controller_3") do
        post :create, params: { origin: "NYC,NY",
                                destination: "London, UK",
                                api_key: user.api_key
                              }

        expect(response).to have_http_status(400)

        parsed_response = JSON.parse(response.body)

        expect(parsed_response).to have_key("error")
        expect(parsed_response["error"]).to eq("Invalid trip request")
      end
    end

    it "returns a successful response London, UK" do
      VCR.use_cassette("road_trip_controller_4") do
        post :create, params: { origin: "NYC,NY",
                                destination: "London, UK",
                                api_key: "invalid_key"
                              }

        expect(response).to have_http_status(401)

        parsed_response = JSON.parse(response.body)

        expect(parsed_response).to have_key("error")
        expect(parsed_response["error"]).to eq("Unauthorized")
      end
    end
  end
end
