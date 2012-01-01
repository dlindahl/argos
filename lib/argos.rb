require 'bundler/setup'
require 'awesome_print'

require 'json'
require "argos/version"

module Argos
  autoload :Config,     'argos/config'
  autoload :Reporter,   'argos/reporter'
  autoload :Runner,     'argos/runner'

  class << self

    def config
      @@config ||= Config.new
    end

  end

end
