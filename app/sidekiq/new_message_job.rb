# frozen_string_literal: true

class NewMessageJob
  include Sidekiq::Job
  sidekiq_options retry: 5
  sidekiq_options lock: :until_executed

  def perform(chat_id, body)
    message = Message.new(chat_id: chat_id, body: body)
    message.save
    set_pid(message)
  rescue StandardError => e
    $redis.set("#{jid}_new_message", Marshal.dump(OpenStruct.new(errors: [e])))
    Rails.logger&.error("[ERROR]: NewMessageJob: #{e}")
  end

  private

  def set_pid(message)
    errors = message.errors.map { |attr_name, msg| { "#{attr_name}": msg } }
    $redis.set("#{jid}_new_message", Marshal.dump(OpenStruct.new(id: message.id, errors: errors)))
  end
end
