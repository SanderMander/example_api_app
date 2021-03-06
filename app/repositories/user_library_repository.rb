# Repository which return user purchased content
# In Futer it can be splited to several repos one per content type
class UserLibraryRepository < Service
  param :user_id
  param :type

  def call
    Success({
              type: type,
              results: yield(user_content)
            })
  end

  private

  def user_content
    mapped_method = {
      movies: :user_movies,
      seasons: :user_seasons,
      all: :user_all_content,
      remaining: :user_remaining_content
    }[type.to_sym]
    return Failure(:content_type_not_supported) unless mapped_method

    Success(send(mapped_method))
  end

  def user_movies
    purchased_movies.order('movies.created_at desc')
  end

  def user_seasons
    purchased_seasons.includes(:episodes).order('seasons.created_at desc')
  end

  def user_all_content
    {
      movies: user_movies,
      seasons: user_seasons
    }
  end

  def user_remaining_content
    {
      movies: purchased_movies.order(:available_until),
      seasons: purchased_seasons.order(:available_until)
    }
  end

  def purchased_movies
    Movie.joins(:purchases).where(purchases: { expired: false, user_id: user_id })
  end

  def purchased_seasons
    Season.joins(:purchases).where(purchases: { expired: false, user_id: user_id })
  end
end
