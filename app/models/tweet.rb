class Tweet < ActiveRecord::Base
  belongs_to :user
  has_many :likes

 
  def to_s
    content.nil? ? "" : content.slice(0,20)
  end
end
