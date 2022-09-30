class Message < ApplicationRecord
  # relations
  belongs_to :chat
  has_one :system_application, through: :chat
end
