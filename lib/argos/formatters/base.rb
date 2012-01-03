module Argos
  module Formatters
    class Base

      def initialize(*args)
      end

      def source_analyzed( source, analysis )
      end

      def identification_started( file_data )
      end

      def identification_finished( file_data )
      end

      def stop(*)
      end

    end
  end
end