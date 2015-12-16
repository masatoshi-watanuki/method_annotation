require "method_annotation/version"
require 'active_support/dependencies/autoload'

module MethodAnnotation
  extend ActiveSupport::Autoload

  autoload :Base
  autoload :Enable

  eager_autoload do
    autoload :Cache
  end
end

MethodAnnotation.eager_load!

# Deprecated. Removed in version 0.3
module Annotations
end
