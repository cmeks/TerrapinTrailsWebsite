class User < ActiveRecord::Base
	#associations
	has_many :users_trips, dependent: :destroy
  has_many :carpools, dependent: :destroy
	has_many :trips, :through => :users_trips, dependent: :destroy

	#creates the remember token for a user
	attr_accessor :remember_token

	#emails will be stored in downcase, this is standard
	before_save { self.email = email.downcase }

	validates :name,  presence: true, length: { maximum: 50 }

	#making sure emails are valid with the correct regex and are unique
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  	validates :email, presence: true, length: { maximum: 255 }, 
  		format: { with: VALID_EMAIL_REGEX },
  		uniqueness: { case_sensitive: false }

	#make sure the user has a secure password
  	has_secure_password
	
	#passwords MUST have a minimum length of 6
  	validates :password, length: { minimum: 6 }
    #validates :role, numericality: { less_than_or_equal_to: 10 }, numericality: { greater_than: 1}
	
	# Returns the hash digest of the given string.
  	def User.digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
  	end
	
	#generates a secure random token
  	def User.new_token
    	SecureRandom.urlsafe_base64
  	end
	
	#signs a user up for a trip
  	def signup(trip, on_waitlist)
		  users_trips.create(trip_id: trip.id, on_waitlist: on_waitlist)
  	end

  	#checks if a user is on a trip
  	def is_on_trip?(trip)

  		self.users_trips.include?(trip)
  	end

  	# Remembers a user in the database for use in persistent sessions.
  	def remember
    	self.remember_token = User.new_token
    	update_attribute(:remember_digest, User.digest(remember_token))
  	end

  	def authenticated?(remember_token)
  		return false if remember_digest.nil?
    	BCrypt::Password.new(remember_digest).is_password?(remember_token)
  	end

  	# Forgets a user.
  	def forget
    	update_attribute(:remember_digest, nil)
  	end
end
