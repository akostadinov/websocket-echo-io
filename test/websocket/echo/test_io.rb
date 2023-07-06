# frozen_string_literal: true

require "test_helper"

module Websocket
  module Echo
    class TestIo < Minitest::Test
      def test_that_it_has_a_version_number
        refute_nil ::Websocket::Echo::Io::VERSION
      end
    end
  end
end
