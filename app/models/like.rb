class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :tweet

  validates :tweet_id, presence: true
  validates :user_id, presence: true
end
