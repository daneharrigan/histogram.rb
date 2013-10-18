class Histogram
  attr :bins

  def initialize(max)
    @max = max
    @bins = []
  end

  def insert(point)
    update(Bin.new(point, 1))
  end

  def update(bin)
    if false
    else
      @bins << bin
      @bins.sort! { |a, b| a.point <=> b.point }
    end
  end

  def merge(bins)
  end

  def sum
  end

  def uniform
  end

  class Bin
    attr :point
    attr :count

    def initialize(point, count)
      @point = point
      @count = count
    end
  end
end
