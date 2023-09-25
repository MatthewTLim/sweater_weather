class LibraryService

    def self.search_books(location)
      get_url("search.json?q=#{location}")
    end

    def self.get_url(url)
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)
    end

    def self.conn
      Faraday.new(url: 'https://openlibrary.org/')
    end
end