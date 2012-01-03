require 'nestling'

module Argos
  class Identifier

    def echonest
      @nestling ||= Nestling.new( Argos.config[:api_key] )
    end

    def identify( file_data )

      # DEBUG: Hardcoding Billie Jean
      file_data['code'] = "eJxVlIuNwzAMQ1fxCDL133-xo1rnGqNAEcWy_ERa2aKeZmW9ustWVYrXrl5bthn_laFkzguNWpklEmoTB74JKYZSPlbJ0sy9fQrsrbEaO9W3bsbaWOoK7IhkHFaf_ag2d75oOQSZczbz5CKA7XgTIBIXASvFi0A3W8pMUZ7FZTWTVbujCcADlQ_f_WbdRNJ2vDUwSF0EZmFvAku_CVy440fgiIvArWZZWoJ7GWd-CVTYC5FCFI8GQdECdROE20UQfLoIUmhLC7IiByF1gzbAs3tsSKctyC76MPJlHRsZ5qhSQhu_CJFcKtW4EMrHSIrpTGLFqsdItj1H9JYHQYN7W2nkC6GDPjZTAzL9dx0fS4M1FoROHh9YhLHWdRchQSd_CLTpOHkQQP3xQsA2-sLOUD7CzxU0GmHVdIxh46Oide0NrNEmjghG44Ax_k2AoDHsiV6WsiD6OFm8y-0Lyt8haDBBzeMlAnTuuGYIB4WA2lEPAWbdeOabgFN6TQMs6ctLA5fHyKMBB0veGrjPfP00IAlWNm9n7hEh5PiYYBGKQDP-x4F0CL8HkhoQnRWN997JyEpnHFR7EhLPQMZmgXS68hsHktEVErranvSSR2VwfJhQCnkuwhBUcINNY-xu1pmw3PmBqU9-8xu0kiF1ngOa8vwBSSzzNw=="

      begin
        echonest.song.identify(
          :artist => file_data['metadata']['artist'],
          :release => file_data['metadata']['release'],
          :title => file_data['metadata']['title'],
          :code => file_data['code']
        )
      rescue Nestling::MissingParameterError => err
        parse_nestling_error( err )
      end
    end

    def search( song_id )
      puts "NOT YET IMPLEMENTED"
      # song_id = song_id.first
      # 
      # ap "song id"
      # ap song_id
      # 
      # # results = echonest.artist(:id => song_id[:artist_id]).songs( :results => 100, :start => 449)
      # results = echonest.song.profile(
      #   :id => song_id[:id],
      #   :bucket => [ 'id:7digital-US', 'tracks' ]
      # )
      # ap results
    end

  private

    def parse_nestling_error( err )
      nestling_message = case err.message.split(' - ').first
        when "api_key"
          "Invalid EchoNest API Key: #{Argos.config[:api_key].inspect}"
        end

      $stderr.puts <<-EOS
      
      #{'*'*50}
      #{nestling_message}

      EOS
      exit(1)
    end

  end
end
