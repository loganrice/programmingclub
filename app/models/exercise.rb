class Exercise < ApplicationRecord
  belongs_to :unit
  has_many :submissions
  has_many :users, through: :submissions
end
