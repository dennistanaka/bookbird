class PagesController < ApplicationController
	skip_before_action :authenticate_user!, only: [:main, :about]

	def main
	end

end
