module Histogram
  class Inspector
    def initialize
      if defined?(::Rails)
        require "histogram/framework/rails"
      end

      # Sinatra
      # Rack
      # Puma
      # Unicorn
    end
  end
end
