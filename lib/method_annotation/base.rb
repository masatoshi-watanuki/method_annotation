module MethodAnnotation
  class Base
    class << self
      attr_accessor :before_procs, :after_procs, :around_procs, :list, :annotation_name, :describe

      def before(&block)
        (@before_procs ||= []) << block
      end

      def after(&block)
        (@after_procs ||= []) << block
      end
      
      def around(&block)
        (@around_procs ||= []) << block
      end
    end
  end
end
