module Argos
  class Runner
    class << self

      def autorun
        at_exit { exit run($stderr, $stdout).to_i }
      end

      # @overload add_formatter(formatter)
      #
      # Adds a formatter to the formatters collection. `formatter` can be a
      # string representing any of the built-in formatters (see
      # `built_in_formatter`), or a custom formatter class.
      #
      # ### Note
      #
      # For internal purposes, `add_formatter` also accepts the name of a class
      # and path to a file that contains that class definition, but you should
      # consider that a private api that may change at any time without notice.
      def add_formatter(formatter_to_use, path=nil)
        formatter_class =
          built_in_formatter(formatter_to_use) ||
          custom_formatter(formatter_to_use) ||
          (raise ArgumentError, "Formatter '#{formatter_to_use}' unknown - maybe you meant 'documentation' or 'progress'?.")

        formatters << formatter_class.new(path ? file_at(path) : @@output)
      end

      alias_method :formatter=, :add_formatter

      def formatters
        @formatters ||= []
      end

      def reporter
        @reporter ||= begin
          add_formatter('progress') if formatters.empty?
          Reporter.new(*formatters)
        end
      end

      def run(err = $stderr, out = $stdout)
        @@output = out
        options = Argos.config

        reporter.report( options[:sources] )

        return 1 # TODO: Proper retval?
      end

    private

      def built_in_formatter(key)
        case key.to_s
        # when 'd', 'doc', 'documentation', 's', 'n', 'spec', 'nested'
        #   require 'rspec/core/formatters/documentation_formatter'
        #   RSpec::Core::Formatters::DocumentationFormatter
        # when 'h', 'html'
        #   require 'rspec/core/formatters/html_formatter'
        #   RSpec::Core::Formatters::HtmlFormatter
        # when 't', 'textmate'
        #   require 'rspec/core/formatters/text_mate_formatter'
        #   RSpec::Core::Formatters::TextMateFormatter
        when 'p', 'progress'
          require 'argos/formatters/progress'
          Argos::Formatters::Progress
        end
      end

      def custom_formatter(formatter_ref)
        if Class === formatter_ref
          formatter_ref
        elsif string_const?(formatter_ref)
          begin
            eval(formatter_ref)
          rescue NameError
            require path_for(formatter_ref)
            eval(formatter_ref)
          end
        end
      end

      def string_const?(str)
        str.is_a?(String) && /\A[A-Z][a-zA-Z0-9_:]*\z/ =~ str
      end

    end
  end
end
