class TweetMailerWorker
  @queue = :tweet

  def self.perform like_id
    like = Like.find(like_id)
    like.send_tweet_mail
  end
end