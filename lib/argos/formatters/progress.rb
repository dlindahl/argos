require_relative 'base'

module Argos
  module Formatters
    class Progress < Argos::Formatters::Base

      def source_analyzed( source, analysis )
        # TODO: Figure out why flush isn't working...
        $stdout.write "Analyzing #{source}\n"
        # $stdout.flush
      end

      def identification_started( file_data )
        $stdout.write "    Identification starting... "
      end

      def identification_succeeded( file_data, song_id )
        $stdout.write "OK.\n"
        # $stdout.flush
      end

      def retagging( mp3_file, file_data, song_id )
        $stdout.write "    Retagging... "
      end

      def retagged( mp3_file, file_data, song_id )
        $stdout.write "Done.\n"
        # $stdout.flush
      end

      def renaming( mp3_path, file_data, song_id )
        $stdout.write "    Renaming... "
      end

      def renamed( old_name, new_name, * )
        $stdout.write "Done.\n"
        # $stdout.flush
      end

      def not_renamed( old_name, file_data, song_id )
        $stdout.write "Skipped.\n"
        # $stdout.flush
      end

      def identification_failed( file_data )
        $stdout.write "Failed.\n"
        # $stdout.flush
      end

      def identification_finished( file_data )
        $stdout.write "    Finished.\n"
        # $stdout.flush
      end

    end
  end
end
