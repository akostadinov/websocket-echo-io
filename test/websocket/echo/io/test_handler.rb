# frozen_string_literal: true

require "test_helper"

class Websocket::Echo::Io::TestHandler < Minitest::Test # rubocop:disable Style/ClassAndModuleChildren
  attr_reader :handler, :mock

  def setup
    @handler = Websocket::Echo::Io::Handler.new
    @mock = Object.new
  end

  def test_on_open
    mock.expects(:timeout=)
    mock.expects(:write)

    handler.on_open(mock)
  end

  def test_echoes
    msg = "This is boring."
    mock.expects(:write).with(msg)

    handler.on_message(mock, msg)
  end

  def test_goodbye
    msg = "Goodbye, beauty."
    mock.expects(:write).with(msg)
    mock.expects(:write).with(handler.class::GOODBYE_LINE)
    mock.expects(:close)

    handler.on_message(mock, msg)
  end

  def test_on_shutdown
    mock.expects(:write).with(handler.class::SHUTDOWN_LINE)

    handler.on_shutdown(mock)
  end
end
