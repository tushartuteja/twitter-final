class HomeController < ApplicationController
  before_action :authenticate_user


  def index
  	@tweets = current_user.feed
    search = params[:search]
    if search
      query = "content like '%#{search}%' "
      @tweets = @tweets.where(query)
    end

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
    followee_id = params[:followee_id]
    follow_mapping = FollowMapping.where(:follower_id => current_user.id, :followee_id => followee_id).first
    unless follow_mapping
        follow_mapping = FollowMapping.create(:follower_id => current_user.id, :followee_id => followee_id)
    else
        follow_mapping.destroy
    end

    return redirect_to '/users'
  end

  def users
    @users = User.where('id != ?', current_user.id)
  end

  def followers
    @users = current_user.followers
  end

  def followees
    @users = current_user.followees
  end



  
end
