class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings

    if params[:ratings].nil?
      if session[:ratings].nil?
        # Não veio nada, e não tinha nada guardado.
        # Cria e popula a sessão
        session[:ratings] = {}
        @all_ratings.each do |r|
          session[:ratings][r] = 1
        end
      end
    else
      # Veio params
      session[:ratings] = params[:ratings]
    end

    if params[:sort_by]
      session[:sort_by] = params[:sort_by]
    else
      session[:sort_by] = "id"
    end

    if params[:ratings].nil? || params[:sort_by].nil?
      redirect_to movies_url(sort_by: session[:sort_by], ratings: session[:ratings])
      return
    end

    @movies = Movie.where(rating: session[:ratings].keys)

    if params[:sort_by].to_s == 'title'
      @sort_by_title = 'hilite'
      @movies = @movies.order(params[:sort_by])
    elsif params[:sort_by].to_s == 'release_date'
      @sort_by_release_date = 'hilite'
      @movies = @movies.order(params[:sort_by])
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
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
