class ApiKey < ApplicationRecord
  before_create :generate_access_token

  def self.generate_access_token
    begin
      access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end
end
