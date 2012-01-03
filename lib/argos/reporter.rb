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
          notify :source_analyzed, source, analysis

          analysis.each do |file_data|
            notify :identification_started, file_data

            song_id = identify file_data
            if song_id.empty?
              notify :identification_failed, file_data
            else
              notify :identification_succeeded, file_data, song_id
              search song_id
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
      Argos.analyze source
    end

    def identify( file_data )
      Argos.identify file_data
    end

    def search( song_id )
      Argos.search song_id
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
