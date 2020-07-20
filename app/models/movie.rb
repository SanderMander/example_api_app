class Movie < ApplicationRecord
  validates :title, :plot, presence: true
end
