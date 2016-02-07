class Membership < ActiveRecord::Base
  belongs_to :beer_club
  belongs_to :user

  validate :membership_exists

  def membership_exists
    if Membership.where(user_id: user_id).map(&:beer_club_id).include? beer_club_id
      errors.add(:user, "This user has a membership to this club already!")
    end
    @beer_clubs = BeerClub.all
  end
end
