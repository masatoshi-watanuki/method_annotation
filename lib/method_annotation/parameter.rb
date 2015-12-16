module MethodAnnotation
  class Parameter
    attr_accessor :original, :args, :method_name

    def initialize(original: nil, args: nil, method_name: nil)
      @original = original
      @args = args
      @method_name = method_name
    end
  end
end
