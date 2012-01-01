module Argos
  class Runner
    class << self

      def autorun
        at_exit { exit run($stderr, $stdout).to_i }
      end

      def formatters
        @formatters ||= []
      end

      def reporter
        @reporter ||= begin
          # add_formatter('progress') if formatters.empty?
          Reporter.new(*formatters)
        end
      end

      def run(err=$stderr, out=$stdout)
        options = Argos.config
        reporter.report( options[:sources] ) do |source|
          ap source
        end

        return 1 # TODO: Proper retval?
      end

    end
  end
end
