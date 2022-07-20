class Tag < ApplicationRecord
  has_many :taggings
  has_many :albums, through: :taggings
end
