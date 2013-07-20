# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#

class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :password_confirmation
	has_secure_password
	has_many :microposts, dependent: :destroy # udalenie postov po defaultu v sluchae udalenia ih usera
	
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy#udalenie vzaimootnoshenii po defaultu pri udalenii usera
	has_many :followed_users, through: :relationships, source: :followed

	 has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy

   has_many :followers, through: :reverse_relationships, source: :follower

	before_save { |user| user.email = email.downcase } # downcase the email attribute before saving the user to the database 
	before_save :create_remember_token # Rails ishet etot metod i vipolniaet ego pered sohraneniem

	validates :name,  presence: true, length: { maximum: 50 } # validates for length of name

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i   # validates for email format          
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }    # validates for the uniqueness                           
	
	validates :password, presence: true, length: { minimum: 6 }# validates for length of the passowrd
	validates :password_confirmation, presence: true		  #presence validation for the password confirmation
	
	# validates :name, presence: true
	# validates :email, presence: true
	

		def feed
   		Micropost.from_users_followed_by(self)		
  	end

  	def following?(other_user)  # chitaet li user soobshenia drugih userov
    	relationships.find_by_followed_id(other_user.id)
  	end

 	  def follow!(other_user) # sozdanie vzaimootnoshenii s other_userom
    	relationships.create!(followed_id: other_user.id)
  	end

  	def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
 		end

	private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
