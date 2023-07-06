# frozen_string_literal: true

require_relative "handler"

module Websocket
  module Echo
    module Io
      class Server
        class << self
          def start
            app = proc do |env|
              if env["rack.upgrade?"] == :websocket
                env["rack.upgrade"] = Handler.new
                [0, {}, []] # It's possible to set cookies for the response.
              elsif env["rack.upgrade?"] == :sse
                puts "SSE connections can only receive data from the server, the can't write."
                env["rack.upgrade"] = Handler.new
                [0, {}, []] # It's possible to set cookies for the response.
              else
                body = "Upgrade connection to Websocket to enter echo mode."
                [405, { "Content-Length" => body.bytesize, "Content-Type" => "text/plain" }, [body]]
              end
            end

            Iodine.listen service: :ws, address: "::", port: 3003, handler: app
            Iodine.start
          end
        end
      end
    end
  end
end
