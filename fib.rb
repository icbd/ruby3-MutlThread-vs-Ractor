#!/usr/bin/env ruby
# frozen_string_literal : true

FIB_COUNT = 36

def fib(n)
  return n if n <= 1

  fib(n - 1) + fib(n - 2)
end

if __FILE__ == $PROGRAM_NAME
  require 'benchmark'

  time = Benchmark.measure do
    FIB_COUNT.times do |n|
      fib(n)
    end
  end

  puts time # 1.969311   0.001214   1.970525 (  1.970992)
end
