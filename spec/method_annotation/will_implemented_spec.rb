require 'spec_helper'

describe MethodAnnotation::WillImplemented do
  class WillImplementedTestClass
    include MethodAnnotation::Enable

    attr_reader :call_count

    will_implemented
    def bar ; end
  end
  class WillImplementedTestChildClass < WillImplementedTestClass ; end
  class WillImplementedTestGrandChildClass < WillImplementedTestChildClass ; end

  [WillImplementedTestClass, WillImplementedTestChildClass, WillImplementedTestGrandChildClass].each do |target_class|
    context target_class do
      it 'raise NotImplementedError' do
        target = target_class.new
        expect { target.bar }.to raise_error(NotImplementedError)
      end
    end
  end

  class WillImplementedOverrideClass < WillImplementedTestClass
    attr_reader :call_override_method_count

    def bar
    end
  end

  context WillImplementedOverrideClass do
    it 'not raise NotImplementedError' do
      target = WillImplementedOverrideClass.new
      expect { target.bar }.not_to raise_error
    end
  end
end
