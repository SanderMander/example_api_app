# Service which perform purchasing of content
class PurchaseContentService < Service
  CONTENT_PRICE = 2.99
  EXPIRATION_PERIOD = 2.days

  param :user
  param :params

  def call
    content = yield load_content
    yield validate_price
    yield validate_content_purchase(content)
    purchase = yield create_purchase(content)
    yield set_expiration(purchase)
    Success(purchase)
  end

  private

  def load_content
    valid_content_types = %w[Movie Season]
    return Failure(:wrong_content_type) unless valid_content_types.include? params['content_type'].to_s

    Success(params['content_type'].constantize.find(params['content_id']))
  rescue ActiveRecord::RecordNotFound
    Failure(:content_not_found)
  end

  def create_purchase(content)
    purchase = Purchase.create(
      user: user,
      content: content,
      price: params['price'],
      quality: params['quality'],
      available_until: EXPIRATION_PERIOD.from_now
    )
    if purchase.valid?
      Success(purchase)
    else
      Failure(purchase.errors.full_messages)
    end
  end

  def set_expiration(purchase)
    # I've decided to use delayed job for switching expired flag because in my opinion it will be
    # the most efficient way in case of perfomance
    # Another options was add where(available_until < Time.current) condition but i think this will be
    # much slower than using indexed bool attribute
    # Also in case if below job will fail by any reason we can add cron job
    # which could check expired purchases daily and disable it for preventing extra usage
    # from users
    ExpirePuchaseJob.set(wait_until: EXPIRATION_PERIOD).perform_later(purchase)
    Success(:ok)
  end

  def validate_price
    return Failure(:prices_are_not_equal) if params['price'].to_f != CONTENT_PRICE

    Success(:ok)
  end

  def validate_content_purchase(content)
    return Failure(:content_already_was_bought) unless \
      user.purchases.where(content: content, expired: false).count.zero?

    Success(:ok)
  end
end
