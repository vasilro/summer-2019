
class TestimonialsController < ApplicationController
  post '/places/:place_id/testimonials' do
    return redirect '/sign_in' unless current_user
    @place = Place.find(params[:place_id])
    new_testimonial = @place.testimonials.build(
      text: params[:testimonial_text],
      rating: params[:rating],
      user: current_user
    )
    @testimonials = @place.testimonials
    if new_testimonial.save
      redirect "/places/#{params[:place_id]}"
    else
      @error = new_testimonial.errors.full_messages.join('; ')
      erb :place
    end
  end
end
