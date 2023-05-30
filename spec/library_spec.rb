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
end