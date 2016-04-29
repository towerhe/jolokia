require 'spec_helper'

describe Jolokia do
  it 'creates an instance of Jolokia::Client' do
    instance = Jolokia.new
    expect(instance).to be_a(Jolokia::Client)
  end
end
