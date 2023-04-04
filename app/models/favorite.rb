class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :house, foreign_key: 'house_id'
  validates :house_id, uniqueness: { scope: :user_id, message: "has already been favorited by this user" }
end
