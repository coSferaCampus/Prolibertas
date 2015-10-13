Airbrake.configure do |config|
  config.api_key = 'd50665c312f6a73d8682f6e90926f380'
  config.host    = 'errores.nosolosoftware.biz'
  config.port    = 80
  config.secure  = config.port == 443
end
