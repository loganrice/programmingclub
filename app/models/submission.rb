class Submission < ApplicationRecord
  has_one_attached :file
  belongs_to :user
  belongs_to :exercise
  has_one :unit, through: :exercise
end
