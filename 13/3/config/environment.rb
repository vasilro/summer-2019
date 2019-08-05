require 'digest'
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/session'
require 'sinatra/flash'

set :database, { adapter: 'sqlite3',
                 database: 'db/restorator.db' }

require_relative '../app/controllers/users_controller'
require_relative '../app/controllers/places_controller'
require_relative '../app/controllers/sessions_controller'
require_relative '../app/models/place'
require_relative '../app/models/testimonial'
require_relative '../app/models/user'
