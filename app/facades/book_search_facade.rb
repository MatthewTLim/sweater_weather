class BookSearchFacade
  def receive_book_search(location)
    book_search = LibraryService.search_books(location)
    BookSearch.new(book_search)
  end
end