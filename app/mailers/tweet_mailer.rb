class TweetMailer < ActionMailer::Base

  default from: "alchemyaug2016@gmail.com"


  def tweet_mail like
    @liked_by = like.user
    @tweet_user = like.tweet.user
    @like = like
    mail(to: @tweet_user.email, subject: "Your Tweet is liked")
  end


end