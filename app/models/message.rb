# frozen_string_literal: true

class Message < ApplicationRecord
  include SearchableMessage

  # relations
  belongs_to :chat
  has_one :system_application, through: :chat

  # validations
  validates :number, :chat, presence: true
  validates :body, length: { maximum: 5000 }, allow_nil: true
  validates :number, uniqueness: { scope: [:system_application] }
  validates :number, numericality: { greater_than_or_equal_to: 0 }
  validates :number, inclusion: { in: ->(i) { [i.number_was] } }, on: :update

  # call backs
  before_validation :generate_number, on: :create
  after_create :increment_chat_messages

  private

  def generate_number
    messages = chat.messages
    self.number = messages.empty? ? 1 : (messages.last.number + 1)
  end

  def increment_chat_messages
    # chat&.with_lock do
    chat.increment!(:messages_count)
    # end
  end
end
