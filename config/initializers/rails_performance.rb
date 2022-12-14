# frozen_string_literal: true

if defined?(RailsPerformance)
  RailsPerformance.setup do |config|
    if ENV['REDIS_URL']
      config.redis = Redis::Namespace.new("#{Rails.env}-rails-performance",
                                          redis: Redis.new(url: ENV['REDIS_URL']))
    end
    config.duration = 4.hours

    config.debug = false # currently not used>
    config.enabled = true

    # default path where to mount gem
    # config.mount_at = '/admin/site_performance'

    # protect your Performance Dashboard with HTTP BASIC password
    config.http_basic_authentication_enabled = false
    # config.http_basic_authentication_user_name = 'admin'
    # config.http_basic_authentication_password = '1234'

    # if you need an additional rules to check user permissions
    config.verify_access_proc = proc { |_controller| true }
    # for example when you have `current_user`
    # config.verify_access_proc = proc { |controller| controller.current_user && controller.current_user.admin? }

    # You can ignore endpoints with Rails standard notation controller#action
    # config.ignored_endpoints = ['HomeController#contact']
  end
end
