require_relative 'application_controller'

class TestimonialsController < ApplicationController
  post '/places/:place_id/testimonials' do
    return redirect '/sign_in' unless current_user
    @place = Place.find(params[:place_id])
    new_testimonial = @place.testimonials.build(
      text: params[:testimonial_text],
      rating: params[:rating],
      user: current_user
    )
    unless new_testimonial.save
    flash[:notice] = new_testimonial.errors.full_messages.join('; ')
    @testimonial_text = params[:testimonial_text]
    erb :place
    else
    redirect "/places/#{params[:place_id]}"
    end
  end
end
