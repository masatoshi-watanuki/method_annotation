module MethodAnnotation
  class Lazy < MethodAnnotation::Base
    self.annotation_name = 'lazy'
    self.describe = 'It method is lazy'

    class LazyProxy < BasicObject
      undef_method(*superclass.instance_methods.select { |method| !method.to_s.start_with?('__') })

      def initialize(param)
        @param = param
      end

      def method_missing(message, *args)
        __target__.__send__(message, *args)
      end

      private

      def __target__
        unless @run
          @target = @param.original.call(@param)
          @run = true
        end
        @target
      end
    end

    around { |param| LazyProxy.new(param) }
  end
end

