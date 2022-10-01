# frozen_string_literal: true

REDIS_URL = if Rails.env.test? || Rails.env.development?
              'redis://localhost:6379'
            else
              Rails.application.credentials[:redis_url]
            end

if REDIS_URL.present?
  $redis = Redis.new(url: REDIS_URL)
  Rails.application.config.cache_store = :redis_cache_store, {
    url: REDIS_URL,
    connect_timeout: 30, # Defaults to 20 seconds
    read_timeout: 0.2, # Defaults to 1 second
    write_timeout: 0.2, # Defaults to 1 second
    reconnect_attempts: 1,   # Defaults to 0
    pool_size: 5,
    pool_timeout: 5
  }
end
