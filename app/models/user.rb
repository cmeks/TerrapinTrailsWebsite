class User < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save   :downcase_email
  before_create :create_activation_digest

	#associations
	has_many :users_trips, dependent: :destroy
  has_many :carpools, dependent: :destroy
	has_many :trips, :through => :users_trips

	#emails will be stored in downcase, this is standard
	before_save { self.email = email.downcase }

	validates :first_name,  presence: true, length: { maximum: 50 }
  validates :last_name,  presence: true, length: { maximum: 50 }
  validates :ec_name,  presence: true, length: { maximum: 50 }
  validates :ec_type,  presence: true, length: { maximum: 50 }
  validates :ec_phone1,  presence: true
  validates :ec_email,  presence: true, length: { maximum: 50 }

	#making sure emails are valid with the correct regex and are unique
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  	validates :email, presence: true, length: { maximum: 255 }, 
  		format: { with: VALID_EMAIL_REGEX },
  		uniqueness: { case_sensitive: false }

    validates :ec_email,  presence: true, format: { with: VALID_EMAIL_REGEX }, length: { maximum: 255 }

	#make sure the user has a secure password
  	has_secure_password
	
	#passwords MUST have a minimum length of 6
  	validates :password, length: { minimum: 6 }, allow_blank: true
	
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

    def name
      first_name + " " + last_name
    end

    # Returns true if the given token matches the digest.
    def authenticated?(attribute, token)
      digest = send("#{attribute}_digest")
      return false if digest.nil?
      BCrypt::Password.new(digest).is_password?(token)
    end

    def activate
      update_attribute(:activated, 1)
      update_attribute(:activated_at, Time.zone.now)
    end

    def send_activation_email
      UserMailer.account_activation(self).deliver_now
    end

    # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

    private 

      def downcase_email
        self.email = email.downcase
      end

      def create_activation_digest
        self.activation_token  = User.new_token
        self.activation_digest = User.digest(activation_token)
      end
end
