class InputFilesController < ApplicationController
  def file_for_type(file_type)
    InputFile.where(:file_type => file_type).first || InputFile.new(:file_type => file_type)
  end
  def new
    file_type = params[:id] || 'Super Bowls'
    @input_file = file_for_type(file_type)
  end
  def create
    ops = params[:input_file]
    @input_file = file_for_type(ops[:file_type])
    @input_file.body = ops[:body]
    @input_file.save!
    redirect_to :ratings
  end
  def update
    create
  end
  def show
    @input_file = file_for_type(params[:id])
    render :json => @input_file
  end
end
