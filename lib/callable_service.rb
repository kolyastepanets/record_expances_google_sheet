module CallableService
  extend ActiveSupport::Concern

  module ClassMethods
    def call(...)
      new(...).call
    end
  end
end
