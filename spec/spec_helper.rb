require 'rubygems'
require 'bundler'
Bundler.setup(:default, :test)

require 'jolokia'

require 'webmock/rspec'
require 'pry'

RSpec.configure do |c|
  c.mock_with :rspec
end
