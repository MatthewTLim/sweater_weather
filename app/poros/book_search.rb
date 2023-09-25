class BookSearch
  attr_reader :total_books_found, :books

  def initialize(attributes)
    @total_books_found = attributes[:numFound]
    @books = attributes[:docs].map do |book_data|
      {
      title: book_data[:title],
      isbn: book_data[:isbn]
      }
    end
  end
end