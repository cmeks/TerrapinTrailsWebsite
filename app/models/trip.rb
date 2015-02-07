class Trip < ActiveRecord::Base
	#including the wysiwyg editor
	include Bootsy::Container

	  #associations
    belongs_to :user
    has_many :carpools, dependent: :destroy
  	has_many :users_trips, dependent: :destroy
  	has_many :users, :through => :users_trips

  	#make sure trips get ordered from newest to oldest
  	default_scope -> { order(start_date: :desc) }

  	#validations
  	validates :name, presence: true, length: { maximum: 100 }
  	validates :description, presence: true
  	validates :start_date, presence: true
    validates :status, presence: true, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 2}
  	#validates :pretrip_location, presence: true, allow_nil: true
    validates :cost, presence: true, numericality: {greater_than_or_equal_to: 0}
    #validates :pretrip_datetime, presence: true, allow_nil: true
    validates :spots, presence: true, numericality: { greater_than: 0 }
    validates :location, presence: true
    validates :experience_level, presence: true
    validates :end_date, presence: true, date: { :after_or_equal_to => :start_date, message: 'must be after or equal to the start date'}
end
