require 'spec_helper'

describe Jolokia::Client do
  let(:url) { 'http://localhost:8080/jolokia' }
  let(:client) { Jolokia::Client.new(url: url) }

  before do
    client.stub(:connection) do
      @conn = Faraday.new do |b|
        b.request :json
        b.response :json
        b.adapter :test do |stub|
          stub.post('/') do |env|
            posted_as = env[:request_headers]['Content-Type']
            body = JSON.parse(env[:body]).merge('status' => 200)

            [200, {'Content-Type' => posted_as }, JSON.generate(body)]
          end
        end
      end
    end
  end

  describe '#request' do
    shared_examples 'Request executed successfully' do
      it 'passes valid params' do
        expect(response).to match_json_expression(options)
      end
    end

    let(:response) do
      client.request :post, options
    end

    context 'when reading attributes' do
      let(:options) do
        {
          'type' => 'read',
          'mbean' => 'java.lang:type=Memory',
          'attribute' => attribute,
          'status' => 200
        }
      end

      context 'only a single attribute' do
        let(:attribute) { 'HeapMemoryUsage' }

        it_should_behave_like 'Request executed successfully'
      end

      context 'multi-attributes' do
        let(:attribute) { ['HeapMemoryUsage', 'NonHeapMemoryUsage'] }

        it_should_behave_like 'Request executed successfully'
      end
    end

    context 'when writing an attribute' do
      let(:options) do
        {
          'type' => 'write',
          'mbean' => 'java.lang:type=ClassLoading',
          'attribute' => 'Verbose',
          'value' => true,
          'status' => 200
        }
      end

      it_should_behave_like 'Request executed successfully'
    end

    context 'when executing JMX operations (exec)' do
      context 'without any params' do
        let(:options) do
          {
            'type' => 'exec',
            'mbean' => 'java.lang:type=Memory',
            'operation' => 'gc',
            'status' => 200
          }
        end

        it_should_behave_like 'Request executed successfully'
      end

      context 'with params' do
        let(:options) do
          {
            'type' => 'exec',
            'mbean' => 'java.lang:type=Threading',
            'operation' => 'dumpAllThreads',
            'arguments' => [true, true],
            'status' => 200
          }
        end

        it_should_behave_like 'Request executed successfully'
      end
    end
  end
end
