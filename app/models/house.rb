class House < ApplicationRecord
    has_many :favorites
    has_many :users_who_favorited, through: :favorites, source: :user
end
