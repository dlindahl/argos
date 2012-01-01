module Argos
  class Reporter

    def initialize( *formatters )
      @formatters = formatters
    end

    def report( sources )
      start
      begin
        yield self
      ensure
        finish
      end
    end

    def start
      @start = Time.now
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
