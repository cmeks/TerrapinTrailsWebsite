class StaticPagesController < ApplicationController
	before_action :correct_user, only: [:change_role]

	def home
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

	private

		def correct_user
			user = current_user
			redirect_to(root_url) unless user == current_user && user.role > 7
		end
end
