require 'bundler/setup'
require 'awesome_print'

# require 'rspec/autorun'

require 'simplecov'
SimpleCov.start do
end

require 'argos'

RSpec.configure do |config|
  # config.filter_run :focus => true
  # config.mock_with :mocha
end
