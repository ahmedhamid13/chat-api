class SystemApplication < ApplicationRecord
  # relations
  has_many :chats, dependent: :destroy
  
  # validations
  validates :name, presence: true
  validates :name, length: { maximum: 255 }
  validates :token, presence: { message: "please try again" }, uniqueness: { message: "please try again" }
  validates :chats_count, numericality: { greater_than_or_equal_to: 0, less_than: ->(i) { i.chats.count + 1 } }
  validates :token, inclusion: { in: ->(i) { [i.token_was] } },
            on: :update

  # call backs
  before_validation :generate_token, on: :create
  before_save do
    self.chats_count = chats.count
  end

  private 

  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(20, false)
      break random_token unless SystemApplication.exists?(token: random_token)
    end
  end
end
