# histogram.rb

A Ruby implementation of Yael Ben-Haim's [A Streaming Parallel Decision Tree
Algorithm][1] paper.

## Algorithms

1. `update` implemented
2. `merge` implemented
3. `sum`
4. `uniform`

1: http://jmlr.org/papers/volume11/ben-haim10a/ben-haim10a.pdf

## Steps

Generate histograms basd on code paths.

1. Create a key based on the controller, views and models, possibly an md5sum
2. Calculate histogram data for each controller, view, and model
3. For every 10 seconds post results to aggregator service
