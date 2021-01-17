# frozen_string_literal: true

require "./fib.rb"

CPU_COUNT = 6 * 2

def show(session)
  begin
    path = session.gets.split(" ")[1]

    session.print "HTTP/1.1 200\r\n"
    session.print "Content-Type: text/html\r\n"
    session.print "\r\n"

    # IO
    if path.include?("io")
      session.print ">>>IO\n"
      2.times do
        sleep(1)
        session.print "#{Time.now}\n"
      end
      session.print "<<<IO\n"
    end

    # Calculation
    if path.include?("cpu")
      session.print ">>>Calculation\n"
      FIB_COUNT.times do |n|
        session.print "fib(#{n}) = #{fib(n)}\n"
      end
      session.print "<<<Calculation\r\n"
    end

  rescue Exception => e
    puts e
  ensure
    session.close
  end
end
