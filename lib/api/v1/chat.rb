# frozen_string_literal: true

module Api
  module V1
    module Chat
      def chat_json(chat, includes = [], _options = {})
        return {} unless chat

        res = chat.as_json(include_root: false,
                           except: %w[id],
                           only: %w[number messages_count created_at updated_at])

        res[:application_token] = chat.system_application.token
        res[:application] = chat.system_application if includes.include?(:application)
        res[:messages] = chat.messages if includes.include?(:messages)

        res
      end

      def chats_json(chats, includes = [], options = {})
        chats.map { |s| chat_json(s, includes, options) }
      end
    end
  end
end
