class SystemApplication < ApplicationRecord
  # relations
  has_many :chats, dependent: :destroy
  
  # validations
  validates :name, presence: true
  validates :name, length: { maximum: 255 }
  validates :token, presence: { message: "please try again" }, uniqueness: { message: "please try again" }
  validates :chats_count, numericality: { greater_than_or_equal_to: 0, less_than: ->(i) { i.chats.size + 1 } }
  validates :token, inclusion: { in: ->(i) { [i.token_was] } }, on: :update

  # call backs
  ## has_secure_token :token 
  ### I prefered using :generate_token method, to validate the uniqueness of token through active record
  before_validation :generate_token, on: :create

  private 

  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(24, false)
      break random_token unless SystemApplication.exists?(token: random_token)
    end
  end
end
