class Service
  extend Dry::Initializer
  include Dry::Monads[:result, :do]

  def self.call(*args)
    new(*args).call
  end
end