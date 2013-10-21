module Histogram
  class DB
    def self.record(id)
      return records[id] ||= Record.new
    end

    def self.flush!
    end

    private

    def self.records
      @events ||= {}
    end

    class Record
      attr_accessor :controller
      attr_accessor :views
      attr_accessor :models

      def initialize
        @controller = nil
        @views = []
        @models = []
      end
    end
  end
end
