class Movie < ApplicationRecord
  validates :title, :plot, presence: true
  has_many :purchases, as: :content
end
