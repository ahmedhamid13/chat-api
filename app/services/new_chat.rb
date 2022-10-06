# frozen_string_literal: true

class NewChat
  attr_reader :application_id, :jid

  def self.create(application_id:)
    new(application_id).call
  end

  def initialize(application_id)
    @application_id = application_id
  end

  def call
    @jid = NewChatJob.set(queue: :new_chat).perform_async(application_id)
    wait_till_proceed
    result = Marshal.load(get_result)
    $redis.del("#{jid}_new_chat")

    if result.errors.empty?
      Operation::Success.new(value: result)
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
    $redis.get("#{jid}_new_chat")
  end
end
