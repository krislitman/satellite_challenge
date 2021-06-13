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
    if Satellite.current_average < 160 && @in_danger == false && @counter < 6
      @counter += 1
      okay_message
    elsif Satellite.current_average < 160 && in_danger == false && @counter >= 6
      @counter += 1
      @in_danger = true
      danger_message
    elsif Satellite.current_average < 160 && in_danger == true && @counter > 6
      @counter += 1
      danger_message
    elsif Satellite.current_average > 160 && @in_danger == true 
      @in_danger = false
      @resume_counter = 6
      @counter = 6
      sustained_message
    elsif @resume_counter > 0
      @in_danger = false
      @resume_counter -= 1
      @counter = 0
      sustained_message
    else
      @counter = 0
      okay_message
    end
  end
  
  private
  
  def okay_message
    "Altitude is A-OK"
  end
  
  def danger_message
    "WARNING: RAPID ORBITAL DECAY IMMINENT"
  end
  
  def sustained_message
    "Sustained Low Earth Orbit Resumed"
  end
end