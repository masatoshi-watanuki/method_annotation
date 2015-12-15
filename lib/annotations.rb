require 'active_support/dependencies/autoload'

module Annotations
  extend ActiveSupport::Autoload

  eager_autoload do
    autoload :Cache
  end
end

Annotations.eager_load!
