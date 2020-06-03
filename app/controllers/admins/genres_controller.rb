class Admins::GenresController < ApplicationController
	def index
		@genres = Genres.all
		@genre = Genre.new
	end
end
