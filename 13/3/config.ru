require_relative 'config/environment'
require_relative 'app/controllers/application_controller'
require_relative 'app/controllers/places_controller'
require_relative 'app/controllers/users_controller'
require_relative 'app/controllers/sessions_controller'

use PlacesController
use UsersController
use SessionsController

run ApplicationController
