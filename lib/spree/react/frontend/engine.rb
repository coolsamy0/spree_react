module Spree
  module React
    module Frontend
      class Engine < Rails::Engine
        isolate_namespace Spree
      end
    end
  end
end