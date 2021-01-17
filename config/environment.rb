# Load the Rails application.
require_relative 'application'
JWT_SECRET = ENV['jwt_secret']
# Initialize the Rails application.
Rails.application.initialize!
