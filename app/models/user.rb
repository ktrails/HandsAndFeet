# The User model maintains state required to identify a user: first/last name,
#   email address, password information
class User < ActiveRecord::Base
  attr_accessible :firstname, :lastname, :email, :password, :password_confirmation

  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password

  validates :firstname, :presence => true
  validates :lastname,  :presence => true
  validates :email,     :presence => true
  validates_uniqueness_of :email
  validates :password,  :presence => true,
                        :on => :create

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.search(search)
    if search
      where('firstname LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end