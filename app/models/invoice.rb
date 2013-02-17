class Invoice < ActiveRecord::Base
  belongs_to :member
  
  before_create do |i|
    i.token = SecureRandom.urlsafe_base64
  end
end
