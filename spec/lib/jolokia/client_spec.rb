require 'spec_helper'

describe Jolokia::Client do
  it 'creates an instance of Jolokia::Client' do
    url = 'http://localhost:8080/jolokia'
    jolokia = Jolokia::Client.new(url: url)

    jolokia.should be
    jolokia.url.should == url
  end 
end
