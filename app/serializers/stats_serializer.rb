class StatsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :minimum
  set_id { 'null' }
  set_type :five_minute_stats
end