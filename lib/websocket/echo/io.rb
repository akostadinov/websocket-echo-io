# frozen_string_literal: true

require "iodine"

require_relative "io/version"
require_relative "io/server"

module Websocket
  module Echo
    module Io
      class Error < StandardError; end
    end
  end
end
