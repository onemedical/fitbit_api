if ENV["COVERAGE"]
  require "simplecov"
  SimpleCov.start do
    enable_coverage :branch
    track_files "**/*.rb"
  end
end

require "fitbit_api"
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
