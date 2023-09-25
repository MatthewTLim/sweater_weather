class Api::V0::BookSearchController < ApplicationController
  def search
    location = params[:location]
    quantity = params[:quantity].to_i

    unless quantity > 0
      render json: { error: 'Quantity must be a positive integer greater than 0' }, status: :bad_request
      return
    end

    location_facade = LocationFacade.new
    forecast_facade = ForecastFacade.new
    book_search_facade = BookSearchFacade.new

    location_details = location_facade.receive_lat_lng(location)

    lat = location_details.lat
    lng = location_details.lng

    forecast = forecast_facade.receive_forecast(lat, lng)
    books = book_search_facade.receive_book_search(location)

    destination = location

    forecast = {
      summary: forecast.current_weather[:condition],
      temperature: "#{forecast.current_weather[:temp_f].to_i} F"
    }

    total_books_found = books.total_books_found
    books_details = books.books.first(quantity)

    response_data = {
      data: {
        id: 'null',
        type: 'books',
        attributes: {
          destination: destination,
          forecast: forecast,
          total_books_found: total_books_found,
          books: books_details
        }
      }
    }

    render json: response_data
  end
end