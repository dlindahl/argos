module Argos
  class Analyzer

    def analyze( filename )
      cmd = %Q{echoprint-codegen "#{filename}" #{Argos.config[:start]} #{Argos.config[:duration]}}

      output = %x{#{cmd}}

      JSON.parse( output )
    end

  end
end
