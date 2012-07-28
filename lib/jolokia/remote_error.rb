module Jolokia
  class RemoteError < RuntimeError
    attr_reader :status, :message, :stacktrace

    def initialize(status, message, stacktrace)
      @status, @message, @stacktrace = status, message, stacktrace
    end
  end
end
