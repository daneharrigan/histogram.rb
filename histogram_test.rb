$: << File.expand_path("..", __FILE__)
require "minitest/autorun"
require "debugger"
require "histogram"

class HistogramTest < Minitest::Test
  def setup
  end

  def test_10_points_in_5_bins
    histogram = Histogram.new(5)
    [23, 19, 10, 16, 36, 2, 9, 32, 30, 45].each do |n|
      histogram.insert(n)
    end

    assert_equal 2, histogram.bins[0].point
    assert_equal 1, histogram.bins[0].count

    assert_equal 9.5, histogram.bins[1].point
    assert_equal 2, histogram.bins[1].count

    assert_equal 17.5, histogram.bins[2].point
    assert_equal 2, histogram.bins[2].count

    assert_equal 23, histogram.bins[3].point
    assert_equal 1, histogram.bins[3].count

    assert_equal 36, histogram.bins[4].point
    assert_equal 1, histogram.bins[4].count
  end
end
