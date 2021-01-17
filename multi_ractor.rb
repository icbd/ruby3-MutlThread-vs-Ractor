#!/usr/bin/env ruby
# frozen_string_literal : true

require 'socket'
require './helper.rb'

server = TCPServer.new(3000)
workers = CPU_COUNT.times.map do
  Ractor.new do
    loop do
      s = Ractor.recv
      puts s.inspect
      show(s)
    end
  end
end

idx = 0
loop do
  session = server.accept
  workers[idx].send(session, move: true)

  idx += 1
  idx = 0 if idx == CPU_COUNT
end
