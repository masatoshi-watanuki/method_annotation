require 'spec_helper'

describe MethodAnnotation::Cache do
  class CacheTestClass
    include MethodAnnotation::Enable

    attr_reader :call_count

    cache
    def bar
      @call_count ||= 0
      @call_count += 1
      'return_value'
    end
  end
  class CacheTestChildClass < CacheTestClass ; end
  class CacheTestGrandChildClass < CacheTestChildClass ; end

  [CacheTestClass, CacheTestChildClass, CacheTestGrandChildClass].each do |target_class|
    context target_class do
      it 'Second time the value of a cache is not performed is returned' do
        target = target_class.new
        # first
        expect(target.bar).to eq('return_value')
        expect(target.call_count).to eq(1)

        # second
        expect(target.bar).to eq('return_value')
        expect(target.call_count).to eq(1)
      end
    end
  end

  class CacheOverrideClass < CacheTestClass
    attr_reader :call_override_method_count

    def bar
      @call_override_method_count ||= 0
      @call_override_method_count += 1
      super
    end
  end

  context CacheOverrideClass do
    it 'Second time the value of a cache is not performed is returned' do
      target = CacheOverrideClass.new
      # first
      expect(target.bar).to eq('return_value')
      expect(target.call_count).to eq(1)
      expect(target.call_override_method_count).to eq(1)

      # second
      expect(target.bar).to eq('return_value')
      expect(target.call_count).to eq(1)
      expect(target.call_override_method_count).to eq(2)
    end
  end
end
