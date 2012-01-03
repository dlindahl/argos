require "mp3info"

module Argos
  class Retagger

    def retag( mp3_path, file_data, song_id )
      song = song_id.first

      Mp3Info.open( mp3_path ) do |mp3|
        mp3.tag.title = song[:title]
        mp3.tag.artist = song[:artist_name]
        # TODO: Comments, album, covert art, etc.
      end
    end

  end
end
