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
    if string.length == 4
      string
    else
      Date.parse(string).year.to_s
    end
  end


end 