class Api::V0::BookSearchController < ApplicationController
  def search
    quantity = params[:quantity].to_i

    unless quantity > 0
      return render_error('Quantity must be a positive integer greater than 0')
    end

    location_facade = LocationFacade.new
    forecast_facade = ForecastFacade.new
    book_search_facade = BookSearchFacade.new

    location_details = location_facade.receive_lat_lng(params[:location])

    lat = location_details.lat
    lng = location_details.lng

    forecast = forecast_facade.receive_forecast(lat, lng)
    books_response = book_search_facade.receive_book_search(params[:location])

    render_books_response(params[:location], forecast, books_response, quantity)
  end

  private

  def render_error(message)
    render json: { error: message }, status: :bad_request
  end

  def render_books_response(destination, forecast, books_response, quantity)
    total_books_found = books_response.total_books_found
    books_details = books_response.books.first(quantity)

    response_data = {
      data: {
        id: 'null',
        type: 'books',
        attributes: {
          destination: destination,
          forecast: formatted_forecast(forecast),
          total_books_found: total_books_found,
          books: books_details
        }
      }
    }

    render json: response_data
  end

  def formatted_forecast(forecast)
    {
      summary: forecast.current_weather[:condition],
      temperature: "#{forecast.current_weather[:temp_f].to_i} F"
    }
  end
end
