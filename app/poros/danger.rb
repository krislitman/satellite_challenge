class Danger
  attr_reader :counter,
              :in_danger,
              :resume_counter

  
  def initialize
    @counter = 0
    @in_danger = false
    @resume_counter = 0
  end
  
  def in_danger?
    @in_danger
  end
  
  def current_check
    if Satellite.current_average < 160 && @in_danger == false && @resume_counter == 0 && @counter < 6
      @counter += 1
      okay
    elsif Satellite.current_average < 160 && in_danger == true && resume_counter == 0 && @counter >= 6
      @counter += 1
      in_danger
    elsif Satellite.current_average > 160 && @in_danger == true && @resume_counter == 0
      @resume_counter = 6
      @counter = 6
      sustained
    elsif @resume_counter > 0
      @resume_counter -= 1
      @counter -= 1
      sustained
    else
      @counter = 0
      okay
    end
  end
  
  private
  
  def okay
    "Altitude is A-OK"
  end
  
  def in_danger
    "WARNING: RAPID ORBITAL DECAY IMMINENT"
  end
  
  def sustained
    "Sustained Low Earth Orbit Resumed"
  end
end