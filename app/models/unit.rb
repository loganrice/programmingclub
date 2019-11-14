class Unit < ApplicationRecord
  has_many :exercises
  has_many :submissions, through: :exercises
  has_many :users, through: :submissions
end
