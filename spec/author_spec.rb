require './lib/author'
require './lib/book'

RSpec.describe Author do
  before(:each) do
    @charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
  end

  it 'exists' do
    expect(@charlotte_bronte).to be_a (Author)
  end

  it 'can show name' do
    expect(@charlotte_bronte.name).to eq ("Charlotte Bronte")
  end

  it 'starts wiht no books' do
    expect(@charlotte_bronte.books).to eq ([])
  end

  it 'can write books' do
    jane_eyre = @charlotte_bronte.write("Jane Eyre", "October 16, 1847")

    expect(jane_eyre.title).to eq ("Jane Eyre")
    expect(jane_eyre.class).to eq(Book)
  end

  it 'can store books written' do
    jane_eyre = @charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    villette = @charlotte_bronte.write("Villette", "1853")

    expect(@charlotte_bronte.books).to eq ([jane_eyre, villette])
  end
end