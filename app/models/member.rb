class Member < ActiveRecord::Base

	has_one :profile
	has_many :payments
	has_many :events
	has_many :jobs
	belongs_to :committee
	
	validates_presence_of :firstname, :lastname

  devise :confirmable, :database_authenticatable, :recoverable, :registerable, :rememberable, :trackable, :validatable
  		 # :registerable, :token_authenticatable, :lockable and :timeoutable

  attr_accessible :leader, :firstname, :lastname, :email, :password, :password_confirmation, :random_password, :committee_name, :birthday
  
  def last_name_first
  	"#{lastname}, #{firstname}"
  end
end
