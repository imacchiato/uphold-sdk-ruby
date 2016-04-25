if ENV['CI']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end

require 'uphold'
require 'climate_control'
require 'pry'

Dir[File.join(Uphold::ROOT_PATH, '..', 'spec/support/**/*.rb')].each { |f| require f }

class DummyLogger
  def self.info(_message); end
  def self.debug(_message); end
end
Uphold.logger = DummyLogger

def with_modified_env(options, &block)
  ClimateControl.modify(options, &block)
end

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
  end

  config.before do
    Uphold.sandbox = true
  end
end
