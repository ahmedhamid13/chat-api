# frozen_string_literal: true

class NewMessage
  attr_reader :chat_id, :body, :jid

  def self.create(chat_id:, body:)
    new(chat_id, body).call
  end

  def initialize(chat_id, body)
    @chat_id = chat_id
    @body = body
  end

  def call
    @jid = NewMessageJob.set(queue: :new_message).perform_async(chat_id, body)
    wait_till_proceed
    result = Marshal.load(get_result)
    $redis.del("#{jid}_new_message")

    if result.errors.empty?
      Operation::Success.new(value: Message.find(result.id))
    else
      Operation::Failure.new(errors: result.errors)
    end
  end

  private

  def wait_till_proceed
    retries = 80
    until get_result
      sleep 0.1
      retries.pred
      break if retries.negative?
    end
  end

  def get_result
    $redis.get("#{jid}_new_message")
  end
end
