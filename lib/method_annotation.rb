require "method_annotation/version"
require 'active_support/dependencies/autoload'

module MethodAnnotation
  extend ActiveSupport::Autoload

  autoload :Base
  autoload :Enable
  autoload :Parameter

  eager_autoload do
    autoload :Cache
    autoload :Trace
  end
end

MethodAnnotation.eager_load!
