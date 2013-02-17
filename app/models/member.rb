class Member < ActiveRecord::Base
  has_one :profile
  has_many :invoices
  has_many :payments
  has_many :events
  has_many :jobs
  
  belongs_to :committee
  
  validates_presence_of :firstname, :lastname

  devise :confirmable, :database_authenticatable, :recoverable, :registerable, :rememberable, :trackable, :validatable
       # :registerable, :token_authenticatable, :lockable and :timeoutable

  attr_accessible :leader, :firstname, :lastname, :email, :password, :password_confirmation, :random_password, :committee_name, :birthday
  
  def full_name
    "#{firstname} #{lastname}"
  end
  
  def last_name_first
    "#{lastname}, #{firstname}"
  end
  
  def has_balance
    invoiced_at && !invoices.last.paid
  end
  
  def invoiced_at
    if invoices.count>0
      return invoices.last.updated_at
    else
      return nil
    end
  end
  
  def invoice(dollars)
    if has_balance
      invoice = invoices.last
    else
      invoice = invoices.create(:amount => dollars, :member_id => self.id)
    end
    invoice.send_count+=1
    if invoice.send_count>6
      self.active = false
      self.save
      p 'Deactivated '+full_name
    else
      invoice.save
      MemberMailer.send_invoice(invoice).deliver
      p 'Sent invoice #'+invoice.send_count.to_s+' to '+full_name
    end
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