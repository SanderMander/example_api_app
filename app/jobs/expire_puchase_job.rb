class ExpirePuchaseJob < ApplicationJob
  queue_as :default

  def perform(purchase)
    purchase.update_attribute(:expired, true)
  end
end
