require 'method_annotation'

module Annotations
  class Cache < MethodAnnotation::Base
    self.annotation_name = 'cache'
    self.describe = 'It is cached after the second time the execution result of the method is returned from the cache'

    around do |original, *args|
      @__chached ||= {}

      key = "#{self.class}__#{__method__}".to_sym
      @__chached[key] = original.call(*args) unless @__chached.key?(key)

      @__chached[key]
    end
  end
end

