require "rails_helper"

RSpec.describe "Location Service" do
  describe "#class methods" do
    it "can retrieve a book by location" do
      location = "Portland,OR"

      location = LibraryService.search_books(location)

      expect(location).to be_a(Hash)
      expect(location).to have_key(:numFound)
      expect(location).to have_key(:start)
      expect(location).to have_key(:numFoundExact)
      expect(location[:docs]).to be_an(Array)
    end
  end
end
