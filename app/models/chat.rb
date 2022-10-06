# frozen_string_literal: true

class Chat < ApplicationRecord
  # relations
  belongs_to :system_application
  has_many :messages, dependent: :destroy

  # validations
  validates :number, :system_application, presence: true
  validates :number, uniqueness: { scope: [:system_application] }
  validates :messages_count, numericality: { greater_than_or_equal_to: 0 }
  validates :number, numericality: { greater_than_or_equal_to: 0 }
  validates :number, inclusion: { in: ->(i) { [i.number_was] } }, on: :update

  # call backs
  before_validation :generate_number, on: :create
  after_create :increment_application_chats

  private

  def generate_number
    chats = system_application.chats
    self.number = chats.empty? ? 1 : (chats.last.number + 1)
  end

  def increment_application_chats
    system_application&.with_lock do
      system_application.increment!(:chats_count)
    end
  end
end
