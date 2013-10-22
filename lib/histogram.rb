require "histogram/version"

module Histogram
  autoload :VERSION, "histogram/version"
  autoload :Engine, "histogram/engine"
  autoload :Inspector, "histogram/inspector"
  autoload :DB, "histogram/db"
  autoload :Request, "histogram/request"
end

Histogram::Inspector.new
