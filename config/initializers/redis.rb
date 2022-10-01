# frozen_string_literal: true

if ENV["REDIS_URL"].present?
  $redis = Redis.new(url: ENV["REDIS_URL"])
  Rails.application.config.cache_store = :redis_cache_store, {
    url: ENV["REDIS_URL"],
    connect_timeout: 30, # Defaults to 20 seconds
    read_timeout: 0.2, # Defaults to 1 second
    write_timeout: 0.2, # Defaults to 1 second
    reconnect_attempts: 1,   # Defaults to 0
    pool_size: 5,
    pool_timeout: 5
  }
end
