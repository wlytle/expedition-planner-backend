# Load the Rails application.
require_relative 'application'
JWT_SECRET = ENV['jwt_secret']
MAP_QUEST = ENV['map_quest']
# Initialize the Rails application.
Rails.application.initialize!
