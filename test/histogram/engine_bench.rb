require "test_helper"

class Histogram::EngineBench < Minitest::Benchmark
  SIZE = 1000

  def setup
    @histogram = Histogram::Engine.new(SIZE)
  end

  def bench_insert
    assert_performance_linear(0.000001) do |n|
      n.times { |i| @histogram.insert(i) }
    end
  end

  def bench_merge
    assert_performance_linear(0.000001) do |n|
      @h2 = Histogram::Engine.new(SIZE)
      n.times do |i|
        @histogram.insert(i)
        @h2.insert(i)
      end

      @histogram.merge(@h2.bins)
    end
  end
end
