require 'jolokia/version'
require 'jolokia/client'

module Jolokia
  class << self
    def new(opts = {})
      Jolokia::Client.new(opts)
    end
  end
end
