class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]
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

  def generate_otp
    self.otp = rand(9000) + 1000
    self.otp_expiry = Time.now
    #Send Otp
    save!
  end

  def verify_otp otp
    if Time.now - self.otp_expiry  < 5.minutes
      return otp == self.otp
    else
      generate_otp
      return false
    end
  end

  def generate_access_token
    generated = SecureRandom.hex
    until User.where(access_token: generated).first.nil?
      generated = SecureRandom.hex
    end
    self.access_token = generated
    save!
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.profile_picture = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
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
