Datadog.configure do |c|
  c.use :rails, service_name: 'rails', analytics_enabled: true
end
