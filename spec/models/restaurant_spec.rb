require 'spec_helper'

describe Restaurant, type: :model do
  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: 'Mm')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'is not valid unless it has a unique name' do
  Restaurant.create(name: "Mikes mushroom")
  restaurant = Restaurant.new(name: "Mikes mushroom")
  expect(restaurant).to have(1).error_on(:name)
end
end
