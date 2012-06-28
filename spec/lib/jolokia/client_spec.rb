require 'spec_helper'

describe Jolokia::Client do
  let(:url) { 'http://localhost:8080/jolokia' }

  it 'creates an instance of Jolokia::Client' do
    jolokia = Jolokia::Client.new(url: url)

    jolokia.should be
    jolokia.url.should == url
  end 

  describe '#request' do
    def respond_json(file)
      File.new(File.join(File.dirname(__FILE__), '../../responses', file))
    end

    let(:jolokia) { Jolokia::Client.new(url: url) }

    context 'when reading a single attribute' do
      let(:response) do
        jolokia.request type: :read,
                        mbean: 'java.lang:type=Memory',
                        attribute: 'HeapMemoryUsage'
      end

      before do
        stub_request(:post, url).
          with(
            body: Oj.dump({
              'type' => 'read',
              'mbean' => 'java.lang:type=Memory',
              'attribute' => 'HeapMemoryUsage'
            }),
            headers: {
              'Accept' => '*/*',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          ).to_return(body: respond_json('heap_memory_usage.json'),
                      status: 200)
      end

      subject { response.value }

      specify { response.status.should == 200 }
      its(:max) { should == 477233152 }
      its(:committed) { should == 190382080 }
      its(:init) { should == 134217728 }
      its(:used) { should == 116851464 }
    end
  end
end
