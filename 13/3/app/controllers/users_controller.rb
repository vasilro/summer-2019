require_relative 'application_controller'

class UsersController < ApplicationController
  
  get '/sign_up' do
    erb :sign_up
  end

  post '/users' do
    @new_user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:confirm_password]
      )
    result = @new_user.save
    if result
      session[:user_id] = @new_user.id
      redirect '/'
    else
      flash[:notice] = @new_user.errors.full_messages.join('; ')
      erb :sign_up
    end
  end

end
