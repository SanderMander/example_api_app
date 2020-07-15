class UserLibraryRepository
  extend Dry::Initializer
  include Dry::Monads[:result, :do]

  param :user_id
  param :type

  def self.call(user_id, type)
    new(user_id, type).call
  end

  def call
    Success(Movie.all.to_a)
  end
end