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
  
  def is_current
    if due_date>Date.today
      return true
    else
      return false
    end
  end
  
  def due_date
    if payments.count>0
      pay_date = payments.last.date
      return pay_date+365
    else
      created_at.to_date
    end
  end
  
  def subscribe
    Gibbon.list_subscribe({
      :id => 'e683465573',
      :email_address => self.email,
      :merge_vars => ({
        'FNAME' => self.firstname,
        'LNAME' => self.lastname
      }),
      :double_optin => false
    })
    Gibbon.list_subscribe({
      :id => '2d515044ee',
      :email_address => self.email,
      :merge_vars => ({
        'FNAME' => self.firstname,
        'LNAME' => self.lastname,
        'GROUPINGS' => ([
          {
            :id => 7645, :groups => 'Profile Notifications,Job Notifications,Event Notifications,Official Correspondence'
          }
        ])
      }),
      :double_optin => false
    })
  end
  
  def unsubscribe
    Gibbon.list_unsubscribe({
      :id => 'e683465573',
      :email_address => self.email,
      :send_goodbye => false,
      :send_notify => false
    })
    Gibbon.list_unsubscribe({
      :id => '2d515044ee',
      :email_address => self.email,
      :send_goodbye => false,
      :send_notify => false
    })
  end
end