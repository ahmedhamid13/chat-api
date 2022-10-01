# frozen_string_literal: true

module Api
  module V1
    module SystemApplication
      def application_json(application, includes = [], _options = {})
        return {} unless application

        res = application.as_json(include_root: false,
                                  except: %w[id],
                                  only: %w[name token chats_count created_at updated_at])

        res[:chats] = application.chats if includes.include?(:chats)
        res[:messages] = application.messag :messages if includes.include?(:messages)

        res
      end

      def applications_json(applications, includes = [], options = {})
        applications.map { |s| application_json(s, includes, options) }
      end
    end
  end
end
