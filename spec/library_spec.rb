require './lib/library'
require './lib/author'
require './lib/book'

RSpec.describe Library do
  before(:each) do
    @dpl = Library.new("Denver Public Library")
  end

  it 'exists' do
    expect(@dpl).to be_a(Library)
  end

  it 'has a name' do
    expect(@dpl.name).to eq("Denver Public Library")
  end

  it 'starts with no books' do
    expect(@dpl.books).to eq([])
  end

  it 'starts with no authors' do
    expect(@dpl.authors).to eq([])
  end

  it 'can add authors' do
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    
    @dpl.add_author(charlotte_bronte)
    @dpl.add_author(harper_lee)

    expect(@dpl.authors).to eq([charlotte_bronte, harper_lee])
  end

  it 'automatically adds author books to collection' do
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847") 
    professor = charlotte_bronte.write("The Professor", "1857")
    villette = charlotte_bronte.write("Villette", "1853")

    @dpl.add_author(charlotte_bronte)

    expect(@dpl.books).to eq([jane_eyre, professor, villette])
  end

  it 'can give time frame for authors published books' do
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    charlotte_bronte.write("The Professor", "1857")
    charlotte_bronte.write("Villette", "1853")
    charlotte_bronte.write("Jane Eyre", "October 16, 1847") 

    @dpl.add_author(charlotte_bronte)
    
    expected = {:start=>"1847", :end=>"1857"}
    expect(@dpl.publication_time_frame(charlotte_bronte)).to eq(expected)
  end

  it 'can checkout a book and tracks checkout books' do
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847") 
    villette = charlotte_bronte.write("Villette", "1853") 
    professor = charlotte_bronte.write("The Professor", "1857")
    @dpl.add_author(charlotte_bronte)

    expect(@dpl.checkout(jane_eyre)).to eq(true)
    expect(@dpl.checkout(villette)).to eq(true)
    expect(@dpl.checked_out_books).to eq([jane_eyre, villette])
    expect(@dpl.books).to eq([professor])
  end

  it 'does not allow checkout if books already checked out or nonexistent' do
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    professor = charlotte_bronte.write("The Professor", "1857")
    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")
    @dpl.add_author(charlotte_bronte)
    
    expect(@dpl.checkout(professor)).to eq(true)
    expect(@dpl.checkout(professor)).to eq(false) #already checked out
    expect(@dpl.checkout(mockingbird)).to eq(false) #does not exist here
  end

  it 'can return a book' do
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    professor = charlotte_bronte.write("The Professor", "1857")
    villette = charlotte_bronte.write("Villette", "1853") 
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847") 
    @dpl.add_author(charlotte_bronte)

    @dpl.checkout(professor)
    @dpl.checkout(jane_eyre)

    @dpl.return(professor)
    expect(@dpl.books).to eq([villette, professor])
    expect(@dpl.checked_out_books).to eq([jane_eyre])
  end

  it 'adds count to the books times_checked_out attribute' do
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847") 
    @dpl.add_author(charlotte_bronte)

    expect(jane_eyre.times_checked_out).to eq(0)

    3.times do
      @dpl.checkout(jane_eyre)
      @dpl.return(jane_eyre)
    end
    expect(jane_eyre.times_checked_out).to eq(3)
  end

  it 'shows the most popular book' do
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    professor = charlotte_bronte.write("The Professor", "1857")
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847") 
    @dpl.add_author(charlotte_bronte)

    5.times do 
      @dpl.checkout(professor)
      @dpl.return(professor)
    end
    3.times do 
      @dpl.checkout(jane_eyre)
      @dpl.return(jane_eyre)
    end
    expect(@dpl.most_popular_book).to eq(professor)
  end
end