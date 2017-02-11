class Tweet < ActiveRecord::Base
  belongs_to :user
  has_many :likes

  validates :tweet_id, presence: true
  validates :user_id, presence: true

end
