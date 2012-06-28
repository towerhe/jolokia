require 'spec_helper'

describe Jolokia do
  it 'creates an instance of Jolokia::Client' do
    Jolokia.new.should be_a Jolokia::Client
  end
end
