module MethodAnnotation
  class Async < MethodAnnotation::Base
    self.annotation_name = 'async'
    self.describe = 'It runs the methods of the target asynchronously'

    around { |param| Thread.new { param.original.call(param) } }
  end
end

