require 'rubygems'
require 'bundler'
Bundler.setup(:default, :test)

require 'jolokia'

RSpec.configure do |c|
  c.mock_with :rspec
end
