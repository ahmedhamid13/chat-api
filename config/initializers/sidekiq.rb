require "sidekiq"
require "sidekiq-statistic"
require "sidekiq/web"

if ENV["REDIS_URL"].present?
  Sidekiq.configure_client do |config|
    config.redis = { url: ENV["REDIS_URL"], network_timeout: 30 }
  end

  Sidekiq.configure_server do |config|
    config.redis = { url: ENV["REDIS_URL"], network_timeout: 30 }
  end
end