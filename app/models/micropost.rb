# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Micropost < ActiveRecord::Base
	attr_accessible :content
	belongs_to :user

  validates :user_id, presence: true # validacia sushestvovania	
  validates :content, presence: true, length: { maximum: 140 } # validacia dlini

  default_scope order: 'microposts.created_at DESC' # microposti po ubivaniu 



   def self.from_users_followed_by(user)
     followed_user_ids = user.followed_user_ids
     where("user_id IN (?) OR user_id = ?", followed_user_ids, user)
  end

end
