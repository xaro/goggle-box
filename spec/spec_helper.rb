require 'fakeweb'
require 'goggle-box'
Dir[File.expand_path(File.join(File.dirname(__FILE__),'..', 'lib','**','*.rb'))].each {|f| require f}

FakeWeb.allow_net_connect = false
RSpec.configure do |config|
  config.mock_with :mocha
end