class RunningMan
  attr_reader :start_time, :duration
  def initialize(start_time, duration, &block)
    @start_time = start_time
    @duration = duration
    self.instance_eval &block
  end

  #check to see if time has expired
  #@return [boolean] whether the time has expired
  def time_expired?
    (Time.now - @duration) > @start_time
  end

  #run a block of code for a given time - be sure to add a check/break for time_expired? or it will infinitely loop
  #@param duration [Integer] Number of seconds to run the job for
  #@example 
  #  RunningMan.run_for(2) do
  #    while(true)
  #      #do some processing
  #      break if time_expired?
  #    end
  #  end
  #
  def self.run_for(duration, &block)
    new(Time.now, duration, &block) 
  end

  #run a block of code until a given time - be sure to add a check/break for time_expired? or it will infinitely loop
  #  @param [Time] Time in the future to run the process until
  #  RunningMan.run_until(3.days.from_now) do
  #    while(true)
  #      #do some processing
  #      break if time_expired?
  #    end
  #  end
  #
  def self.run_until(time, &block)
    duration = (time - Time.now).round
    raise "Select a time in the future" if duration < 0
    new(Time.now, duration, &block)
  end
end
