require 'bundler/setup'
require 'awesome_print'

require 'json'
require "argos/version"

module Argos
  autoload :Analyzer,   'argos/analyzer'
  autoload :Config,     'argos/config'
  autoload :Identifier, 'argos/identifier'
  autoload :Reporter,   'argos/reporter'
  autoload :Runner,     'argos/runner'

  class << self

    def config
      @@config ||= Config.new
    end

    def analyzer
      @@analyzer ||= Analyzer.new
    end

    def analyze( filename )
      analyzer.analyze( filename )
    end

    def identifier
      @@identifier ||= Identifier.new
    end

    def identify( source )
      identifier.identify source
    end

  end

end
