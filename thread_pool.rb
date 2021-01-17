# frozen_string_literal: true

class ThreadPool
  def initialize(size: 6)
    @size = size
    @jobs = Queue.new
    @pool = Array.new(size) do
      Thread.new do
        catch(:exit) do
          loop do
            job, args = @jobs.pop
            job.call(*args)
          end
        end
      end
    end
  end

  def schedule(*args, &block)
    @jobs << [block, args]
  end

  def shutdown
    @size.time do
      schedule { throw :exit }
    end

    @pool.map(&:join)
  end
end
