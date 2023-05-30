class Library
  attr_reader :name, :books, :authors

  def initialize(name)
    @name = name
    @books = []
    @authors = []
  end

  def add_author(author)
    @authors << author
    author.books.each do |book|
      @books << book
    end
  end

  def publication_time_frame(author)
    books = author.books
    years = books.map do |book|
      book.publication_year
    end.sort
    {start: years.first, end: years.last}
  end
end