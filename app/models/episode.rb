class Episode < ApplicationRecord
  belongs_to :season, touch: true
  validates :title, :plot, :number, presence: true
end
