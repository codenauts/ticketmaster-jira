$:.unshift(File.expand_path(File.dirname(__FILE__) + '/../lib'))
require 'ticketmaster/jira'

Rspec.configure do |config|
  config.mock_framework = :rspec
end

class FakeJiraTool
  attr_accessor :call_stack, :returns

  def initialize
    @call_stack = []
    @returns = {}
  end

  def method_missing *args
    @call_stack << args
    @returns.delete(args.first) if @returns.key?(args.first)
  end
end
