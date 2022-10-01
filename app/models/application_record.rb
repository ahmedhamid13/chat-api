# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def as_json(options = {})
    options[:except] ||= %i[id lock_version system_application_id chat_id]
    super
  end
end
