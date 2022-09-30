class SystemApplication < ApplicationRecord
  # relations
  has_many :chats, dependent: :destroy
  
  # validations
  validates :name, presence: true
  validates :name, length: { maximum: 255 }
  validates :token, presence: { message: "please try again" }, uniqueness: { message: "please try again" }
  validates :chats_count, numericality: { greater_than_or_equal_to: 0 }

  # call backs
  before_validation :generate_token, on: :create

  private 

  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(20, false)
      break random_token unless SystemApplication.exists?(token: random_token)
    end
  end
end
