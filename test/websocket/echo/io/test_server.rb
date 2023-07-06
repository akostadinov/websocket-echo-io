# frozen_string_literal: true

require "socket"

require "test_helper"

class Websocket::Echo::Io::TestServer < Minitest::Test # rubocop:disable Style/ClassAndModuleChildren
  def teardown
    super
    Iodine.stop
  end

  def test_it_works
    client_handler = EchoChecker.new
    Thread.new { Websocket::Echo::Io::Server.start }

    wait_for_running(5)

    assert wait_for_tcp(host: "localhost", port: Websocket::Echo::Io::Server::PORT)

    Iodine.connect url: "ws://localhost:3003", handler: client_handler
    wait_for(3, message: "Echo not received") { client_handler.echoed }
  end

  private

  # wait until TCP connection to host/port pair can be established
  # @return [TrueClass] returns last exception if connection never established
  # @raise StandardError
  def wait_for_tcp(host:, port:, socket_connect_timeout: 5)
    error = nil
    3.times do
      Socket.tcp(host, port, connect_timeout: socket_connect_timeout) {} # rubocop:disable Lint/EmptyBlock
      return true
    rescue StandardError => exception
      sleep 0.5
      error = exception
    end

    raise(error)
  end

  def wait_for_running(seconds)
    wait_for(seconds, message: "Iodine not running") { Iodine.running? }
  end

  def wait_for(seconds, message: "awaited result not achieved")
    result = nil

    (seconds.to_i * 2).times do
      sleep 0.5
      break if (result = yield)
    end

    assert result, message
  end

  class EchoChecker
    attr_reader :echoed

    def on_open(connection)
      connection.write "my secret message"
    end

    def on_message(connection, message)
      return unless message == "my secret message"

      @echoed = true
      connection.close
    end
  end
end
