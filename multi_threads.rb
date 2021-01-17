#!/usr/bin/env ruby
# frozen_string_literal : true

require 'socket'
require './helper.rb'
require './thread_pool.rb'

server = TCPServer.new(3000)

pool = ThreadPool.new(size: CPU_COUNT)
loop do
  session = server.accept
  pool.schedule(session) do |s|
    puts s.inspect
    show(s)
  end
end
