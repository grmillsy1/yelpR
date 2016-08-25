require 'rails_helper'

describe Review, type: :model do
  it "is invalid if the rating is more than 5" do
    review = Review.new(rating: 10)
    expect(review).to have(1).error_on(:rating)
  end
end

  describe '#average_rating' do
    context 'no reviews' do
      it 'returns "N/A" when there are no reviews' do
        restaurant = Restaurant.create(name: 'The Ivy')
        expect(restaurant.average_rating).to eq 'N/A'
      end
    end
    context 'average review' do
      it 'returns the average rating' do
        restaurant = Restaurant.create(name: 'The Ivy 2')
        restaurant.save(validate: false )
        review = restaurant.reviews.create(rating: 5)
        review1 = restaurant.reviews.create(rating: 3)
        review.save(validate: false)
        review1.save(validate: false)
        expect(restaurant.average_rating).to eq 4
      end
    end

  end
