# frozen_string_literal: true

require 'sidekiq'
require 'sidekiq-statistic'
require 'sidekiq-scheduler'
require 'sidekiq/web'
require 'sidekiq-scheduler/web'

# Configure Sidekiq-specific session middleware
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: '_interslice_session'

if ENV['REDIS_URL'].present?
  Sidekiq.configure_client do |config|
    config.redis = { url: ENV['REDIS_URL'], network_timeout: 30 }

    config.client_middleware do |chain|
      chain.add SidekiqUniqueJobs::Middleware::Client
    end
  end

  Sidekiq.configure_server do |config|
    config.redis = { url: ENV['REDIS_URL'], network_timeout: 30 }

    config.client_middleware do |chain|
      chain.add SidekiqUniqueJobs::Middleware::Client
    end

    config.server_middleware do |chain|
      chain.add SidekiqUniqueJobs::Middleware::Server
    end

    SidekiqUniqueJobs::Server.configure(config)
  end
end
