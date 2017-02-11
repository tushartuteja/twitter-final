class HomeController < ApplicationController
  before_action :authenticate_user

  def index
  	@tweets = Tweet.includes(:user, :likes).all.order(created_at: :desc).limit(50)
  end

  def create_tweet
  	current_user.tweets.create(content: params[:content])
  	return redirect_to '/'
  end


  def like
  	tweet_id = params[:tweet_id]
  	like = current_user.likes.where(tweet_id: tweet_id).first
  	if like 
  		like.destroy
  	else
  		current_user.likes.create(tweet_id: tweet_id)
  	end

  	redirect_to '/'
  end


  def follow
  end

  
end
