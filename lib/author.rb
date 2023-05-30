class Author
  attr_reader :info, :books

  def initialize(info)
    @info = info
    @books = []
  end

  def name
    "#{info[:first_name]} #{info[:last_name]}"
  end

  def write(book_name, pub_date)
    book_info = {
      author_first_name: @info[:first_name],
      author_last_name: @info[:last_name],
      title: book_name,
      publication_date: pub_date
    }
    books << (book = Book.new(book_info))
    book
  end
end