module MethodAnnotation
  class WillImplemented < MethodAnnotation::Base
    self.annotation_name = 'will_implemented'
    self.describe = 'This method is expected to be implemented'

    before do |param|
      fail NotImplementedError.new("Please implement #{self.class}##{param.method_name}")
    end
  end
end

