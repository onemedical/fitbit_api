$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'fitbit_api'
require 'simplecov'

SimpleCov.start do
  enable_coverage :branch
  track_files '{app,lib}/**/*.rb'
end
