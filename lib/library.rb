class Library
  attr_reader :name, 
              :books, 
              :authors, 
              :checked_out_books

  def initialize(name)
    @name = name
    @books = []
    @authors = []
    @checked_out_books = []
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

  def checkout(book)
    if @books.include?(book)
      @checked_out_books << book
      @books.delete(book)
      true
    else
      false
    end
  end

  def return(book)
    if @checked_out_books.include?(book)
      @books << book
      @checked_out_books.delete(book)
      true
    else
      false
    end
  end
end