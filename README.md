# Jolokia

The Jolokia Ruby library provides a ruby API to the to the Jolokia agent.

## Installation

Add this line to your application's Gemfile:

    gem 'jolokia'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jolokia

## Usage

First of all, you need to create an instance of Jolokia::Client to
comunicate with the remote Jolokia Agent. You just need
to pass the url of the Jolokia Agent to the constructor for creating the
client.

```ruby
jolokia = Jolokia.new(url: 'http://localhost:8080/jolokia')
```

And then, you can use the created client to read or write the attributes
of the MBeans, or execute the operations of the MBeans.

```ruby
response = jolokia.request(:post, type: 'read',
                                  mbean: 'java.lang:type=Memory',
                                  attribute: 'HeapMemoryUsage')
pp response

# =>

  {"timestamp"=>1340783789,
   "status"=>200,
   "request"=>
    {"mbean"=>"java.lang:type=Memory",
     "attribute"=>"HeapMemoryUsage",
     "type"=>"read"},
   "value"=>
    {"max"=>477233152,
     "committed"=>190382080,
     "init"=>134217728,
     "used"=>116851464}}
```

### API

`get_attribute(mbean, attribute, path = nil)`
`set_attribute(mbean, attribute, value, path = nil)`
`execute(mbean, operations, args)`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
