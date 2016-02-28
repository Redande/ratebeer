module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    average_rating = ratings.inject(0.0){ |sum, r| sum+r.score } / ratings.count
    average_rating.nan? ? nil : average_rating
  end
end
