module Histogram
  class Engine
    attr :bins

    def initialize(max)
      @max = max
      @bins = []
    end

    def insert(point)
      update(Bin.new(point, 1))
    end

    def update(bin)
      if b = @bins.detect { |b| b.point == bin.point }
        b.count += 1
      else
        @bins << bin
        @bins.sort! { |a, b| a.point <=> b.point }

        if @bins.size > @max
          compress!
        end
      end
    end

    def merge(bins)
      @bins += bins
      @bins.sort! { |a, b| a.point <=> b.point }
      compress!
    end

    private

    def compress!
      while @bins.size > @max do
        gap_idx = -1
        gap_val = Float::MAX

        @bins[0..-2].each_with_index do |cur, i|
          nxt = @bins[i+1]
          gap = nxt.point - cur.point

          if gap < gap_val
            gap_val = gap
            gap_idx = i
          end
        end

        cur = @bins[gap_idx]
        nxt = @bins[gap_idx+1]

        m = (cur.count + nxt.count)
        p = (cur.point + nxt.point) / m

        @bins -= [cur, nxt]
        @bins << Bin.new(p, m)
        @bins.sort! { |a, b| a.point <=> b.point }
      end
    end

    class Bin
      attr :point
      attr :count

      def initialize(point, count)
        @point = point.to_f
        @count = count.to_f
      end

      def count=(v)
        @count = v
      end
    end
  end
end
