
class SessionsController < ApplicationController
  get '/sign_in' do
    erb :sign_in
  end

  post '/sessions' do
    user = User.find_by(email: params[:email]).try(:authenticate, params[:password])
    if user
      session[:user_id] = user.id
      flash[:notice] = 'You successfully logged in!'
      redirect '/'
    else
      @flash_error = 'Invalid email/password combo!'
      @email = params[:email]
      erb :sign_in
    end
  end

  get '/logout' do
    flash[:notice] = 'You successfully logged out!'
    session.delete(:user_id)
    redirect '/'
  end
end
