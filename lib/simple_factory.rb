require "simple_factory/version"

module SimpleFactory
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def simple_factory(*names)
      names.each do |name|
        define_singleton_method(name) do |*args|
          new(*args).send(name)
        end
      end
    end
  end
end
