require 'date'

class Book
  attr_reader :info

  def initialize(info)
    @info = info
  end

  def title
    info[:title]
  end

  def author
   "#{info[:author_first_name]} #{info[:author_last_name]}"
  end

  def publication_year
    string = info[:publication_date]
    Date.parse(string).year
  end


end 