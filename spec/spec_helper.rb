dir = File.expand_path(File.join(File.dirname(__FILE__), '..'))
$LOAD_PATH.unshift(dir, dir + 'lib', dir + '../lib')

require 'mocha/api'
require 'puppet'

unless RUBY_VERSION =~ %r{^1.9}
  require 'coveralls'
  Coveralls.wear!
end

PROJECT_ROOT = File.expand_path('..', File.dirname(__FILE__))

RSpec.configure do |config|
  config.mock_with :mocha
end
