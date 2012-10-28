class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
  	@all_ratings = Movie.get_all_ratings
  	
  	if !params.has_key? "ratings"
  		@checked_ratings = @all_ratings
  	else
  		@checked_ratings = params[:ratings].keys
  	end
  	
		sort_by = params[:sort_by]		
		
		if sort_by.eql? 'title'
			@checked_ratings = flash[:ratings]
			@movies = Movie.order('title ASC').get_movies_by_rating(@checked_ratings)
			@title_css = 'hilite'
			@date_css = ''
			
		elsif sort_by.eql? 'release_date'
			@checked_ratings = flash[:ratings]
			@movies = Movie.order('release_date ASC').get_movies_by_rating(@checked_ratings)
			@date_css = 'hilite'
			@title_css = ''
			
		else
			@movies = Movie.get_movies_by_rating(@checked_ratings)
			@date_css = ''
			@title_css = ''
		end
			
		flash[:ratings] = @checked_ratings
  end
	
  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
