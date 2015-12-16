module MethodAnnotation
  class Cache < MethodAnnotation::Base
    self.annotation_name = 'cache'
    self.describe = 'It is cached after the second time the execution result of the method is returned from the cache'

    around do |param|
      @__chached ||= {}

      key = "#{self.class}__#{param.method_name}".to_sym
      @__chached[key] = param.original.call(param) unless @__chached.key?(key)

      @__chached[key]
    end
  end
end

