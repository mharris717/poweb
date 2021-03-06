class RatingsController < ApplicationController
  def index
  end
  def create
    r = Rating.create!(params[:rating].merge(:status => 'Open'))
    redirect_to '/'
  end
  def update
    r = Rating.find(params[:id])
    r.update_attributes(params[:rating])
    redirect_to '/'
  end
  def next_open
    r = Rating.where(:status => 'Open').first
    render :json => r
  end
  def show
    r = Rating.find(params[:id])
    respond_to do |format|
      format.html do
        if params[:dvoa]
          render :text => "<pre>#{r.raw_str}</pre>"
        else
          render :text => r.output_page
        end
      end
      format.json do
        render :json => r
      end
    end
  end
  def destroy
    r = Rating.find(params[:id])
    r.destroy
    redirect_to '/'
  end
  def clear_ratings
    Rating.destroy_all if params[:abc] == '92'
    redirect_to '/'
  end
    
end