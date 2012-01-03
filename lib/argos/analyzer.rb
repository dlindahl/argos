module Argos
  class Analyzer

    # TODO: Add check for echoprint-codegen binary and exit appropriately if not available.
    def analyze( filename )
      cmd = %Q{echoprint-codegen "#{filename}" #{Argos.config[:start]} #{Argos.config[:duration]}}

      output = %x{#{cmd}}

      JSON.parse( output )
    end

  end
end
