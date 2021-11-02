class PagesController < ApplicationController
  def home
    @city = City.new
    @pagy, @cities = pagy(City.joins(:users).where(users: { id: current_user }))
  end

  def about
  end
end
