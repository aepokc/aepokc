class Member < ActiveRecord::Base

	has_one :profile
	has_many :events
	has_many :jobs

  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  		 # :token_authenticatable, :lockable and :timeoutable

  attr_accessible :leader, :firstname, :lastname, :email, :password, :password_confirmation
  
end
