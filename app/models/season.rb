class Season < ApplicationRecord
  has_many :episodes
  validates :title, :plot, :number, presence: true
end
