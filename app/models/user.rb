require 'uri'

class User < ActiveRecord::Base
  before_create :generate_key

  def generate_key
    self.key = OpenSSL::PKey::RSA::generate(512).to_s
  end

  def public_key
    private_key.public_key
  end

  def private_key 
    OpenSSL::PKey::RSA.new(self.key)
  end

  def email_identifier
    host = URI.parse(ENV.fetch('APP_HOST', 'example.org')).host
    "#{username}@#{host}"
  end
end