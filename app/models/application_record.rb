class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  def as_json(options = {})
    options[:except] ||= [:id, :system_application_id, :chat_id]
    super
  end
end
