require 'jolokia/version'
require 'jolokia/client'
require 'jolokia/remote_error'

module Jolokia
  class << self
    def new(opts = {})
      Jolokia::Client.new(opts)
    end
  end
end
