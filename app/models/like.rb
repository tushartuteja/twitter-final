class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :tweet

  validates :tweet_id, presence: true
  validates :user_id, presence: true

  after_create :send_tweet_mail_async

  def send_tweet_mail
    TweetMailer.tweet_mail(self).deliver_now
  end

  def send_tweet_mail_async
    Resque.enqueue(TweetMailerWorker, id)
  end
end
