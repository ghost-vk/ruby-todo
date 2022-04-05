class User < ApplicationRecord
  has_secure_password
  has_many :projects, dependent: :destroy

  validates :login,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: /\A[a-zA-Z0-9_\.]+\z/ },
            length: { in: 6..20 }

  validates :password_digest,
            presence: true

  validates :name, presence: true,
            format: { with: /\A[a-zA-Z\p{Cyrillic} ]+\z/ },
            length: { in: 2..40 }

  validates :avatar, presence: true,
            format: { with: /\A[a-zA-z\/:\.\d]+\z/ }
end
