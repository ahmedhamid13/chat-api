# frozen_string_literal: true

module Api
  module V1
    module Message
      def message_json(message, includes = [], _options = {})
        return {} unless message

        res = message.as_json(include_root: false,
                              except: %w[id],
                              only: %w[number body created_at updated_at])

        res[:system_application] = message.system_application if includes.include?(:system_application)
        res[:chat] = message.chat if includes.include?(:chat)

        res
      end

      def messages_json(messages, includes = [], options = {})
        messages.map { |s| message_json(s, includes, options) }
      end
    end
  end
end
