# Usually service classes respond to method #call
# With this module you should be able to rewrite:
#
#   SomeService.new(a,b,c).call
#
#   To:
#
#   SomeService.call(a,b,c)
#
# This is useful when you use Sidekiq short delay syntax, like:
#
#  SomeService.delay.call(a,b,c)
#

module CallableService
  extend ActiveSupport::Concern

  module ClassMethods
    def call(*args, &block)
      new(*args, &block).call
    end
  end
end
