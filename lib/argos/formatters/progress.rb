require_relative 'base'

module Argos
  module Formatters
    class Progress < Argos::Formatters::Base

      def source_analyzed( source, analysis )
        ap "SOURCE ANALYZED! #{source}"
      end

      def identification_started( file_data )
        ap "ID STARTED!"
      end

      def identification_succeeded( file_data, song_id )
        ap "SUCCESS!!!!!!"
      end

      def identification_failed( file_data )
        ap "Failed :("
      end

      def identification_finished( file_data )
        ap "ID FINISHED!"
      end

    end
  end
end
