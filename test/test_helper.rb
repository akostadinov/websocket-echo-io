# frozen_string_literal: true

$LOAD_PATH.unshift("#{__dir__}/lib")
$LOAD_PATH.unshift("#{File.dirname(__dir__)}/lib")

unless ENV["DISABLE_COVERAGE"] == "1"
  require "simplecov"
  SimpleCov.start do
    enable_coverage :branch
    enable_coverage_for_eval
    add_filter %r{^/test/}
    track_files "lib/**/*.rb" # do not miss non-required files
  end
end

require "websocket/echo/io"

require "minitest/autorun"
require "mocha/minitest"
