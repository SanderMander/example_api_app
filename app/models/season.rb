class Season < ApplicationRecord
  has_many :episodes, -> { order(:number) }, dependent: :destroy
  validates :title, :plot, :number, presence: true
end
