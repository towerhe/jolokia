require 'faraday'
require 'faraday_middleware'
require 'oj'

module Jolokia
  class Client
    attr_accessor :url

    def initialize(opts = {})
      @url = opts[:url]
    end

    def get_attribute(mbean, attribute, path = nil)
      options = { 'type' => 'read', 'mbean' => mbean, 'attribute' => attribute }
      options['path'] = path if path

      request(:post, options)
    end

    def set_attribute(mbean, attribute, value, path = nil)
      options = {
        'type' => 'write',
        'mbean' => mbean,
        'attribute' => attribute,
        'value' => value
      }
      options['path'] = path if path

      request(:post, options)
    end

    def execute(mbean, operation, args)
      options = {
        'type' => 'exec',
        'mbean' => mbean,
        'operation' => operation
      }
      options['arguments'] = args if args

      request(:post, options)
    end

    def request(method, opts)
      resp = connection.send(method, '', opts)

      resp.body
    end

    private

    def connection
      @conn ||= ::Faraday.new(url) do |f|
        f.request  :json
        f.response :json
        f.adapter  :net_http
      end
    end
  end
end
