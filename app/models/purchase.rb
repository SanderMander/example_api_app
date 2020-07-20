class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :content, polymorphic: true
  validates :price, :quality, presence: true

  enum quality: %w[sd hd]
end
