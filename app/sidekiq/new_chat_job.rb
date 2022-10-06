# frozen_string_literal: true

class NewChatJob
  include Sidekiq::Job
  sidekiq_options retry: 5
  sidekiq_options lock: :until_executed

  def perform(system_application_id)
    chat = Chat.new(system_application_id: system_application_id)
    chat.save
    set_pid(chat)
  rescue StandardError => e
    $redis.set("#{jid}_new_chat", Marshal.dump(OpenStruct.new(errors: [e])))
    Rails.logger&.error("[ERROR]: NewChatJob: #{e}")
  end

  private

  def set_pid(chat)
    $redis.set("#{jid}_new_chat", Marshal.dump(chat))
  end
end
