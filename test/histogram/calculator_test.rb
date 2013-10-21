$: << File.expand_path("../../lib", __FILE__)
require "minitest/autorun"
require "histogram/calculator"

class Histogram::CalculatorTest < Minitest::Test
  def test_10_points_in_5_bins
    histogram = Histogram::Calculator.new(5)
    [23, 19, 10, 16, 36, 2, 9].each do |n|
      histogram.insert(n)
    end

    assert_equal 5, histogram.bins.size

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

  def test_0_to_10_twice
    histogram = Histogram::Calculator.new(10)
    10.times { |n| histogram.insert(n) }
    10.times { |n| histogram.insert(n) }

    assert_equal 10, histogram.bins.size

    10.times do |n|
      assert_equal n, histogram.bins[n].point
      assert_equal 2, histogram.bins[n].count
    end
  end

  def test_merge_two_0_to_10_bins
    h1 = Histogram::Calculator.new(10)
    h2 = Histogram::Calculator.new(10)

    10.times do |n|
      h1.insert(n)
      h2.insert(n)
    end

    assert_equal 10, h1.bins.size
    assert_equal 10, h2.bins.size

    h1.merge(h2.bins)

    10.times do |n|
      assert_equal n, h1.bins[n].point
      assert_equal 2, h1.bins[n].count
    end
  end

  def test_merge_bins_0_to_10_and_5_to_10
    h1 = Histogram::Calculator.new(10)
    h2 = Histogram::Calculator.new(10)

    10.times { |n| h1.insert(n) }
    (5...10).to_a.each { |n| h2.insert(n) }

    assert_equal 10, h1.bins.size
    assert_equal 5, h2.bins.size

    h1.merge(h2.bins)
    assert_equal 10, h1.bins.size

    (0..4).to_a.each do |n|
      assert_equal n, h1.bins[n].point
      assert_equal 1, h1.bins[n].count
    end

    (5..9).to_a.each do |n|
      assert_equal n, h1.bins[n].point
      assert_equal 2, h1.bins[n].count
    end
  end
end
