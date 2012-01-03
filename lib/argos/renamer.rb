require "mp3info"

module Argos
  class Renamer

    attr_accessor :old_filename, :new_filename

    def initialize( mp3_file, file_data, song_id )
      @delimiter = " - "

      @mp3_file, @file_data, @song_id = mp3_file, file_data, song_id

      build_paths
      build_filenames
    end

    def rename!
      Mp3Info.open( @mp3_file ) do |mp3|
        tag = mp3.tag

        @buffer.tap do |buffer|
          buffer << tag.artist
          buffer << "ALBUM_NAME" # tag.album
          buffer << "TRACK" # tag.track
          # buffer << tag.disc_no
          buffer << tag.title
        end
      end
      @new_filename = @buffer.join( @delimiter ) + @extension

      if rename?
        # TODO: raise if file already exists
        File.rename( @mp3_file, File.join( @path, @new_filename ) )
      else
        @new_filename
      end

      [ old_filename, new_filename ]
    end

    def new_filename
      @new_filename if rename?
    end

  private

    def rename?
      @old_filename != @new_filename and not @buffer.empty?
    end

    def build_paths
      @path = File.dirname @mp3_file
    end

    def build_filenames
      @buffer = []
      @new_filename = nil
      @old_filename = File.basename @mp3_file
      @extension    = File.extname @mp3_file
    end

  end
end
