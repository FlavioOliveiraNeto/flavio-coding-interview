class TweetsController < ApplicationController
  def index
    tweets = Tweet.all
    tweets = tweets.by_user(params[:user_id]) if params[:user_id].present?

    page = params[:page]&.to_i || 1
    per_page = params[:per_page]&.to_i || 5

    offset = (page - 1) * per_page
    paginated_tweets = tweets.offset(offset).limit(per_page)

    render json: paginated_tweets
  end
end
