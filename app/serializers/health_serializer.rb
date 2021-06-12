class HealthSerializer
  include FastJsonapi::ObjectSerializer
  attributes :message
  set_id { 'null' }
  set_type :satellite_health
end