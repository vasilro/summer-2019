require_relative 'application_controller'

class PlacesController < ApplicationController
  get '/places/:id' do
    @place = Place.find(params[:id])
    erb :place
  end
end
