class User < ActiveRecord::Base
  has_many :beer_clubs, through: :memberships
  has_many :memberships, dependent: :destroy
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
                       length: { minimum: 3,
                                 maximum: 15 }
  validates :password, length: { minimum: 4 },
                       format: { with: /\A(?=.*[A-Z])(?=.*\d).+\z/ }

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :beer_clubs, through: :memberships

  def to_s
    "#{self.username}"
  end

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end
end
