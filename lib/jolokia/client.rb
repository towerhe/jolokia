require 'faraday'
require 'faraday_middleware'

module Jolokia
  class Client
    attr_accessor :url
    attr_accessor :username
    attr_accessor :password

    def initialize(opts = {})
      @url = opts[:url]
      @username = opts[:username]
      @password = opts[:password]
    end

    def get_attribute(mbean, attribute, path = nil)
      options = { 'type' => 'read', 'mbean' => mbean, 'attribute' => attribute }
      options['path'] = path if path

      request(:post, options)['value']
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

    def execute(mbean, operation, args = nil)
      options = {
        'type' => 'exec',
        'mbean' => mbean,
        'operation' => operation
      }

      if args
        options['arguments'] = args.is_a?(Array) ? args : [args]
      end

      request(:post, options)
    end

    def request(method, opts)
      resp = connection.send(method, '', opts)

      if resp.body['status'] != 200
        raise RemoteError.new(resp.body['status'],
                              resp.body['error'],
                              resp.body['stacktrace'])
      end

      resp.body
    end

    private

    def connection
      @conn ||= ::Faraday.new(url) do |f|
        f.request  :json
        f.response :json
        f.adapter  :net_http
        if ( !@username.nil? && !@password.nil? )
          f.basic_auth @username, @password
        end
      end
    end
  end
end
