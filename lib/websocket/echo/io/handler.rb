# frozen_string_literal: true

module Websocket
  module Echo
    module Io
      class Handler
        def on_open(client)
          # Set a connection timeout
          client.timeout = 10
          # Write a welcome message
          client.write "WebSocket-Echo-IO server powered by Iodine #{Iodine::VERSION}.\r\n"
        end

        def on_message client, data
          client.write data
          # client.close if data =~ /^bye[\n\r]/
        end

        def on_shutdown(client)
          client.write "Server going away\r\n"
        end
      end
    end
  end
end
