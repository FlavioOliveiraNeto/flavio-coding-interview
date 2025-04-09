class TweetsController < ApplicationController
  def index
    tweets = Tweet.all
    tweets = tweets.by_user(params[:user_id]) if params[:user_id].present?
    render json: tweets
  end
end
