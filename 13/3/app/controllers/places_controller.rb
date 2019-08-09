
class PlacesController < ApplicationController
  get '/places/:id' do
    @place = Place.find(params[:id])
    @average_rating = @place.testimonials.average('rating')
    @average_rating = @average_rating.round 2 if @average_rating
    @testimonials = @place.testimonials
    erb :place
  end
end
