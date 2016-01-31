class Brewery < ActiveRecord::Base
  include RatingAverage
  
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

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
