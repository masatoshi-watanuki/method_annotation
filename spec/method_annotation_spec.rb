require 'spec_helper'
require 'active_support/core_ext'

describe MethodAnnotation do
  it 'has a version number' do
    expect(MethodAnnotation::VERSION).not_to be nil
  end

  describe '.eager_load!' do
    it 'That can be acquired as as MethodAnnotation::Base sub class' do
      expect(MethodAnnotation::Base.subclasses.map(&:annotation_name)).to be_include('cache')
    end
  end
end
