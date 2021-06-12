class StatsFacade
  attr_reader :minimum,
              :maximum,
              :average
  def initialize
    @minimum = find_minimum
    @maximum = find_maximum
    @average = find_average
  end
  
  def find_minimum
    Satellite.where("last_updated <= ? AND last_updated > ?", Time.now, 5.minutes.ago)
    .order(:altitude)
    .limit(1)
    .pluck(:altitude)
  end
  
  def find_maximum
    Satellite.where("last_updated <= ? AND last_updated > ?", Time.now, 5.minutes.ago)
    .order(altitude: :desc)
    .limit(1)
    .pluck(:altitude)
  end
  
  def find_average
    avg = Satellite.where("last_updated <= ? AND last_updated > ?", Time.now, 5.minutes.ago)
    .average(:altitude)
    
    avg.to_f
  end
end