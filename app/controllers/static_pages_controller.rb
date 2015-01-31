class StaticPagesController < ApplicationController
	def home
		render :layout => 'home'
	end

	def about
	end

	def testing
	end
end
