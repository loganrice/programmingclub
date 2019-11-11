class Exercise < ApplicationRecord
  belongs_to :unit
  has_many :submissions
end
