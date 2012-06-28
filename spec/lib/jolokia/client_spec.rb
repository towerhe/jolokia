require 'spec_helper'

describe Jolokia::Client do
  let(:url) { 'http://localhost:8080/jolokia' }

  it 'creates an instance of Jolokia::Client' do
    jolokia = Jolokia::Client.new(url: url)

    jolokia.should be
    jolokia.url.should == url
  end 

  describe '#request' do
    let(:jolokia) { Jolokia::Client.new(url: url) }
    let(:options) do
      {
        'type' => 'read',
        'mbean' => 'java.lang:type=Memory',
        'attribute' => attribute 
      }
    end
    let(:response) do
      jolokia.request options
    end
    let(:response_body) do
      File.new(File.join(File.dirname(__FILE__),
                         '../../responses', fake_response_body))
    end

    before do
      stub_request(:post, url).
        with(
          body: Oj.dump(options),
          headers: {
            'Accept' => '*/*',
            'Content-Type' => 'application/json',
            'User-Agent' => 'Ruby'
          }
      ).to_return(body: response_body,
                  status: 200)
    end

    context 'when reading a single attribute' do
      let(:attribute) { 'HeapMemoryUsage' }
      let(:fake_response_body) { 'heap_memory_usage.json' }

      it 'responds with status 200' do
        response['status'].should == 200
      end

      it 'responds the heap memory usage' do
        response['value'].should == {
          'max' => 477233152,
          'committed' => 190382080,
          'init' => 134217728,
          'used' => 116851464
        }
      end
    end

    context 'when reading multi-attributes' do
      let(:attribute) { ['HeapMemoryUsage', 'NonHeapMemoryUsage'] }
      let(:fake_response_body) { 'heap_memory_usage_and_none.json' }

      it 'responds HeapMemoryUsage and NonHeapMemoryUsage' do
        response['value'].should == {
          'NonHeapMemoryUsage' => {
            'max' => 184549376,
            'committed' => 88866816,
            'init' => 24313856,
            'used' => 88016336
          },
          'HeapMemoryUsage' => {
            'max' => 477233152,
            'committed' => 190447616,
            'init' => 134217728,
            'used' => 104668904
          }
        }
      end
    end
  end
end
