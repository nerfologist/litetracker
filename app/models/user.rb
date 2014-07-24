class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  
  attr_reader :password
  
  after_initialize :ensure_session_token
  
  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end
  
  def self.find_by_credentials(user_params)
    user = User.find_by(email: user_params[:email])
    return user if user && user.is_password?(user_params[:password])
    nil
  end
    
  def gravatar_url
    "http://www.gravatar.com/avatar/#{ Digest::MD5.hexdigest(email) }"
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end
  
  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end
