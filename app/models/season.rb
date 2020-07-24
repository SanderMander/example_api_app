class Season < ApplicationRecord
  has_many :episodes, -> { order(:number) }, dependent: :destroy
  validates :title, :plot, :number, presence: true
  has_many :purchases, as: :content
end
