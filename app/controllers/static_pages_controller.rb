class StaticPagesController < ApplicationController
	before_action :correct_user, only: [:change_role]

	def home
		@trips = Trip.all
		@current = Array.new
		@trips.each do |trip|
			if trip.start_date > Time.now && trip.end_date > Time.now
				@current.push(trip)
			end
		end
		render :layout => 'home'
	end

	def about
	end

	def testing
	end

	def change_role
	end

	def not_implemented
	end

	def officers
	end
	
	def calendar
	end
	
	def albums
	end

	private

		def correct_user
			user = current_user
			redirect_to(root_url) unless user == current_user && user.role > 2
		end
end
