require "histogram/version"

module Histogram
  autoload :VERSION, "histogram/version"
  autoload :Calculator, "histogram/calculator"
  autoload :Inspector, "histogram/inspector"
  autoload :DB, "histogram/db"
end

Histogram::Inspector.new
