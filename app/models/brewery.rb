class Brewery < ActiveRecord::Base
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true
  validates :year, numericality: { greater_than_or_equal_to: 1042,
                                    only_integer: true }
  validate :this_year

  def this_year
    if year > Time.now.year
      errors.add(:year, "Greetings future dude")
    end
  end

  def to_s
    name
  end

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    @year = 2016
    puts "changed year to #{year}"
  end
end
