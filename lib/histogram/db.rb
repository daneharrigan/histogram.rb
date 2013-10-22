require "digest/md5"

# Histogram::DB[String] = Request
# Request#controller
# Request#layout
# Request#views
# Request#models

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
      record.key
      #group = histograms[record.key]
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
      attr_accessor :layout
      attr_accessor :views
      attr_accessor :models

      def initialize
        @views = []
        @models = []
      end

      def key
        Digest::MD5.hexdigest([
            controller(@controller),
            @models.map { |e| model(e) },
            @views.map { |e| view(e) }
          ].flatten.sort.join(","))
      end

      private

      def controller(e)
        e.payload[:controller]+"#"+e.payload[:action]
      end

      def model(e)
        suffix = e.payload[:sql][-12..-1].strip
        s = e.payload[:name].split(" ")[0]
        s << ".where(args)"
        if suffix.include?("LIMIT 1")
          if suffix[0..2] == "ASC"
            s << ".first"
          else 
            s << ".last"
          end
        end

        return s
      end

      def view(e)
        [
          "app/views/"+e.payload[:identifier].split("/app/views/")[1]
        ] + e.children.map { |v| view(v) }.flatten
      end

      def children_keys(children)
        []
      end
    end
  end
end
