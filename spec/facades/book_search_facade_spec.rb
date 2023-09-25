require "rails_helper"

RSpec.describe "ForecastFacade" do
  describe "#class_methods" do
    it "gets books using location" do
      location = "Denver,CO"

      book_search_facade = BookSearchFacade.new
      receive_book_search = book_search_facade.receive_book_search(location)

      expect(receive_book_search).to be_a(BookSearch)
      expect(receive_book_search.books).to be_an(Array)
      expect(receive_book_search.total_books_found).to eq(772)
      expect(receive_book_search.books.first).to have_key(:title)
      expect(receive_book_search.books.first).to have_key(:isbn)
    end
  end
end