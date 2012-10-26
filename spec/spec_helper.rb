require 'rubygems'
require 'bundler'
Bundler.setup(:default, :test)

require 'jolokia'

require 'json_expressions/rspec'
require 'pry'
require 'oj'

RSpec.configure do |c|
  c.mock_with :rspec
end
