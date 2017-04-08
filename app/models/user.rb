class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :tweets
  has_many :likes
  has_many :follower_mappings, class_name: 'FollowMapping', foreign_key: 'followee_id'
  has_many :followee_mappings, class_name: 'FollowMapping', foreign_key: 'follower_id'
  has_many :followers, through: :follower_mappings
  has_many :followees, through: :followee_mappings
  #has_many :feed

  after_create :generate_access_token

  def feed
    users = followees.pluck(:id) + [self.id]
    feed_tweets = Tweet.includes(:user, :likes).where("user_id in (?)", users)
    feed_tweets.order(created_at: :desc)
  end

  def generate_access_token
    generated = SecureRandom.hex
    until User.where(access_token: generated).first.nil?
      generated = SecureRandom.hex
    end
    self.access_token = generated
    save!
  end

  # def followers
  #    	fms = follow_mappings
  #    	followers = []
  #    	follow_mappings.each do |fm|
  #    		followers << fm.follower
  #    	end
  #    	followers
  #    end


  #    def follower_mappings
  #    	FollowMapping.where(followee_id: self.id)
  #    end
end
