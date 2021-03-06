require 'bundler/setup'
require 'awesome_print'

require 'json'
require "argos/version"

module Argos
  autoload :Analyzer,   'argos/analyzer'
  autoload :Config,     'argos/config'
  autoload :Identifier, 'argos/identifier'
  autoload :Renamer,    'argos/renamer'
  autoload :Reporter,   'argos/reporter'
  autoload :Retagger,   'argos/retagger'
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

    def search( song_id )
      identifier.search song_id
    end

    def retagger
      @@retagger ||= Retagger.new
    end

    def retag( mp3_file, file_data, song_id )
      retagger.retag mp3_file, file_data, song_id
    end

    def rename( mp3_file, file_data, song_id )
      Renamer.new( mp3_file, file_data, song_id ).rename!
    end

  end

end
