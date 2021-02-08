class User < ApplicationRecord
    validates :user_name, presence: true, uniqueness: true
    validates :user_name, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6, allow_nil: true}

    after_initialize :ensure_session_token

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end
    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save!
        self.session_token
    end
    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end
    def is_password(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)

    end
end
