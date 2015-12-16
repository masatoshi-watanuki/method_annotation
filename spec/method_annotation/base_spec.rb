require 'spec_helper'

describe MethodAnnotation::Base do
  class BaseInheritedClass < MethodAnnotation::Base
    self.annotation_name = 'base inherited class'
    self.describe = 'for test'

    before { }
    before { }
    after { }
    around { }
  end

  it { expect(BaseInheritedClass.annotation_name).to eq('base inherited class') }
  it { expect(BaseInheritedClass.describe).to eq('for test') }
  it { expect(BaseInheritedClass.before_procs.count()).to eq(2) }
  it { expect(BaseInheritedClass.after_procs.count()).to eq(1) }
  it { expect(BaseInheritedClass.around_procs.count()).to eq(1) }
end
