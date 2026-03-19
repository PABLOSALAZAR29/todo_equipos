class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_one :perfil, dependent: :destroy

  enum :role, { user: 0, admin: 1 }

  def admin?
    role == "admin"
  end

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
