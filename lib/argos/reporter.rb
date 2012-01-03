module Argos
  class Reporter

    def initialize( *formatters )
      @formatters = formatters
    end

    def report( sources )
      start
      begin
        sources.each do |source|
          source = yield source if block_given?

          analysis = analyze( source )

          analysis.each do |file_data|
            notify :identification_started, file_data

            song_id = identify file_data

            unless song_id.empty?
              mp3_path = file_data['metadata']['filename']

              search song_id
              retag  mp3_path, file_data, song_id
              rename mp3_path, file_data, song_id
            end

            notify :identification_finished, file_data
          end

        end
      ensure
        finish
      end
    end

    def start
      @start = Time.now
    end

    def analyze( source )
      Argos.analyze( source ).tap do |analysis|
        notify :source_analyzed, source, analysis
      end
    end

    def identify( file_data )
      Argos.identify( file_data ).tap do |song_id|
        if song_id.empty?
          notify :identification_failed, file_data
        else
          notify :identification_succeeded, file_data, song_id
        end
      end
    end

    def search( song_id )
      # Argos.search song_id
      # notify # ???
    end

    def retag( mp3_path, file_data, song_id )
      Argos.retag mp3_path, file_data, song_id
      notify :retagged, mp3_path, file_data, song_id
    end

    def rename( mp3_path, file_data, song_id )
      # Argos.rename mp3_path, file_data, song_id
      # notify :renamed, source, file_data, song_id
    end


    def finish
      stop
    end

    def stop
      @duration = Time.now - @start if @start
      notify :stop
    end

    def notify( method, *args )
      @formatters.each { |formatter| formatter.send(method, *args) }
    end

  end
end
