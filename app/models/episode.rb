class Episode < ApplicationRecord
  belongs_to :season
  validates :title, :plot, :number, presence: true
end
