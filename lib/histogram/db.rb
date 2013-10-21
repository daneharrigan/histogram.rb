require "digest/md5"

module Histogram
  module DB
    extend self

    def record(id)
      return records[id] ||= Record.new
    end

    def flush!
    end

    def compress(id)
      record = records.delete(id)
      group = histograms[record.key]
      # insert
      # - controller
      # - views
      # - models
    end

    private

    def records
      @records ||= {}
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

      def key
      end
    end
  end
end
