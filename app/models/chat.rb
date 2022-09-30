class Chat < ApplicationRecord
  # relations
  belongs_to :system_application
  has_many :messages, dependent: :destroy

  # validations
  validates :number, :system_application, presence: true
  validates :number, uniqueness: { scope: [:system_application] }
  validates :messages_count, numericality: { greater_than_or_equal_to: 0 }
  validates :number, numericality: { greater_than_or_equal_to: 0, less_than: ->(i) { i.messages.count + 1 } }
  validates :number,
            inclusion: { in: ->(i) { [i.number_was] } },
            on: :update
  # call backs
  before_validation :generate_number, on: :create
  before_save do
    self.messages_count = messages.count
  end

  private
  
  def generate_number
    system_application&.with_lock do
      chats = system_application.chats
      self.number = chats.empty? ? 1 : (chats.last.number + 1)
      # system_application.update(chats_count: system_application.chats_count + 1)
    end
  end
end
