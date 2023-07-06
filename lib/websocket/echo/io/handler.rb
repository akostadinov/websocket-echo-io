# frozen_string_literal: true

module Websocket
  module Echo
    module Io
      class Handler
        GOODBYE_LINE = "See you in a bit."
        SHUTDOWN_LINE = "Server going away\r\n"

        def on_open(client)
          # Set a connection timeout
          client.timeout = 10
          # Write a welcome message
          client.write "WebSocket-Echo-IO server powered by Iodine #{Iodine::VERSION}.\r\n"
        end

        def on_message(client, data)
          client.write data

          return unless /^Goodbye\b/.match?(data)

          client.write GOODBYE_LINE
          client.close
        end

        def on_shutdown(client)
          client.write SHUTDOWN_LINE
        end
      end
    end
  end
end
