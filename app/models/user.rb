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
#

class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :password_confirmation
	has_secure_password
	
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
	private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
