
class ApplicationController < Sinatra::Base

  configure do
    set :views, './app/views'
    enable :sessions
    register Sinatra::Flash
  end

  register Sinatra::Partial
  register Sinatra::Session
  register Sinatra::ActiveRecordExtension

  set :partial_template_engine, :erb

   def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  get '/' do
    @places = Place.all
    erb :index
  end
end
