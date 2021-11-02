class CitiesController < ApplicationController
  before_action :set_city, only: %i[ show edit update destroy]

  def index
    @cities = City.all
  end

  def create
    # Move condition 
    @city = City.find_by(name: params[:city][:name].downcase)
    unless @city.nil?
      unless @city.users.include?(current_user)
        @city.users << current_user
        flash[:success] = "City added successfully!"
        redirect_to(root_url) and return
      else
        flash[:danger] = "City Already Exists!"
        redirect_to(root_url) and return
      end
    else
      @city = City.new(city_params)
      @city.users << current_user
    end
    respond_to do |format|
      if @result = @city.save
        flash[:success] = "City added successfully!"
        format.html { redirect_to root_url }
        format.js
      else
        format.html {
          @city.errors.full_messages.each do |msg|
            flash[:danger] = msg
          end
          redirect_to root_url
        }
        format.js
      end
  end
  end

  def destroy
    respond_to do |format|
      if @result = @city.unsubscribe(@city, current_user)
        format.html { redirect_to root_url, notice: "City was successfully removed." }
        format.js 
      else
        format.html {
          @city.errors.full_messages.each do |msg|
            flash[:danger] = msg
          end
          redirect_to root_url
        }
        format.js
      end
    end
  end

  private
    def set_city
      @city = City.friendly.find(params[:id])
    end

    def city_params
      params.require(:city).permit(:name)
    end
end
