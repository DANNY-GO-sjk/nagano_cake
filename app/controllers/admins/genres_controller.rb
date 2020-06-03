class Admins::GenresController < ApplicationController
	def index
		@genres = Genres.all
		@genre = Genre.new
	end
	def create
		@genre = Genre.new(genre_params)
		if @genre.save
			flash[:notice] = "ジャンル登録が完了しました"
			redirect_to admins_genres_path
		else
			@genres = Genres.all
			render :index
		end
	end

	private
	def genre_params
		params.require(:genre).permit(:name, :is_valid)
	end
end
