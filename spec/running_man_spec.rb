require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "RunningMan" do
  it "should only run for the allotted time" do
    start = Time.now
    RunningMan.run_for(2) do 
      while(true)
        break if time_expired?
      end
    end
    stop = Time.now
    (stop - start).should < 3
    (stop - start).should > 2
  end

  it "should stop execution if the loop completes" do
    start = Time.now
    RunningMan.run_for(2) do
      true
      break if time_expired?
    end
    stop = Time.now

    (stop - start).should < 2

  end

  it "should run until a given time" do
    start = Time.now
    RunningMan.run_until(start + 3) do
      while(true)
        break if time_expired?
      end
    end
    stop = Time.now

    (stop - start).should < 4
    (stop - start).should > 3
  end

end
