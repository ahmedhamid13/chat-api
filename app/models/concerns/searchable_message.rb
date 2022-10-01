# frozen_string_literal: true

module SearchableMessage
  extend ActiveSupport::Concern
  
  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    settings do
      mapping dynamic: false do
        indexes :body, type: :text, analyzer: [:autocomplete, :arabic, :english]
        indexes :chat_id
      end
    end

    def as_indexed_json(options={})
      self.as_json(only: [:id, :body, :number, :chat_id, :created_at, :updated_at])
    end

    def self.search(q:, chat_id:)
      response = __elasticsearch__.search(
          query: {
              bool: {
                  must: [
                      { match: { chat_id: chat_id } },
                      { query_string: { query: "*#{q}*", fields: [:body] } }
                  ]
              }
          }
      )
      response.results.map(&:_source)
    end
  end
end
