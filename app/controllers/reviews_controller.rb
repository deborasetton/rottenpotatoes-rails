class ReviewsController < ApplicationController
  before_filter :has_moviegoer_and_movie, only: [:new, :create]

  def new
    @review = @movie.reviews.build
  end

  def create
    @current_user.reviews << @movie.reviews.build(review_params)
    redirect_to movie_path(@movie)
  end

  protected

  def review_params
    params.permit(review: [:potatoes, :comments])[:review]
  end

  def has_moviegoer_and_movie
    unless @current_user
      flash[:warning] = 'You must be logged in to create a review.'
      redirect_to OmniAuth.login_path(:twitter)
    end

    unless (@movie = Movie.where(id: params[:movie_id]).first)
      flash[:warning] = 'Review must be for an existing movie.'
      redirect_to movies_path
    end
  end
end
