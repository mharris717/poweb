class RatingsController < ApplicationController
  def index
  end
  def create
    r = Rating.create!(params[:rating].merge(:status => 'Open'))
    render :template => 'ratings/index'
  end
  def update
    r = Rating.find(params[:id])
    r.update_attributes(params[:rating])
    render :template => 'ratings/index'
  end
  def next_open
    r = Rating.where(:status => 'Open').first
    render :json => r
  end
  def show
    r = Rating.find(params[:id])
    render :text => r.output_page
  end
  def destroy
    r = Rating.find(params[:id])
    r.destroy
    render :template => 'ratings/index'
  end
  def clear_ratings
    Rating.destroy_all if params[:abc] == '92'
    render :template => 'ratings/index'
  end
    
end