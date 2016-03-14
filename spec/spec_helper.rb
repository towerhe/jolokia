require 'rubygems'
require 'bundler'
Bundler.setup(:default, :test)

require 'jolokia'

require 'json_expressions/rspec'
require 'pry'
require 'oj'

RSpec.configure do |config|
  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end
