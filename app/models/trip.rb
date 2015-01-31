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
  	validates :pretrip_location, presence: true
    validates :cost, presence: true
    validates :pretrip_datetime, presence: true
    validates :spots, presence: true
    validates :location, presence: true
    validates :experience_level, presence: true
    validates :end_date, presence: true
end
