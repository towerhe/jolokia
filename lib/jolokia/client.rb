require 'virtus'
require 'faraday'
require 'faraday_middleware'
require 'oj'

module Jolokia
  class Client
    include ::Virtus

    attribute :url, String

    def request(opts)
      resp = connection.post '', opts

      resp.body
    end

    def connection
      @conn ||= ::Faraday.new(url) do |f|
        f.request  :json
        f.response :json
        f.adapter  :net_http
      end
    end
  end
end
