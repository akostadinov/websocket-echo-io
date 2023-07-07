# frozen_string_literal: true

require_relative "handler"

module Websocket
  module Echo
    module Io
      class Server
        # support heroku custom port
        PORT = ENV["PORT"]&.to_i || 3003

        class << self
          def start
            handler = Handler.new

            app = proc do |env|
              # :nocov: for some reason clover can't detect coverage of these lines
              if env["rack.upgrade?"] == :websocket
                env["rack.upgrade"] = handler
                [0, {}, []] # It's possible to set cookies for the response.
              elsif env["rack.upgrade?"] == :sse
                puts "SSE connections can only receive data from the server, they can't write."
                env["rack.upgrade"] = handler
                [0, {}, []] # It's possible to set cookies for the response.
              else
                body = "Upgrade connection to Websocket to enter echo mode."
                [405, { "Content-Length" => body.bytesize, "Content-Type" => "text/plain" }, [body]]
              end
              # :nocov:
            end

            Iodine.listen service: :ws, address: "::", port: PORT, handler: app
            Iodine.start

            # in case long term running clogs the server, hot restart regularly
            # see https://github.com/boazsegev/iodine#hot-restart
            # Iodine.run_every(4 * 60 * 60 * 1000) do
            #   Process.kill("SIGUSR1", Process.pid) unless Iodine.worker?
            # end
          end
        end
      end
    end
  end
end
