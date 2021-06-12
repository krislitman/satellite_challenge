class StatsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :minimum, :maximum, :average
  set_id { 'null' }
  set_type :five_minute_altitude_stats
end