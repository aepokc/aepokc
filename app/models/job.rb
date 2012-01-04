class Job < ActiveRecord::Base
	belongs_to :member
	
	def current_date
		Date.today
	end
	
	validates :title, :presence => true
	validates :employer, :presence => true
	
	validates_format_of :phone, :with => /[1-9][0-9]{9}/, 
															:message => "- please supply the phone number in the following format: 4058182257",
															:allow_blank => true
  
  def notify
    url = 'http://aepokc.com/emails/jobs/'+self.id.to_s
    campaign = Gibbon.campaign_create({
      :type => 'regular',
      :options => ({
        :list_id => '7fca37265a',
        :subject => 'aep | OKC Career Opportunity',
        :from_email => 'admin@aepokc.com',
        :from_name => 'aep Admin',
        :to_name => '*|FNAME|* *|LNAME|*',
        :title => 'Job Notification: '+self.title,
        :auto_tweet => true
      }),
      :content => ({
        :url => url,
        :text => 'Just letting you know that a new career opportunity has been posted at '+url
      })
    })
    ActiveRecord::Base.logger.info "MailChimp campaign creation response: #{campaign}"
    sender = Gibbon.campaign_send_now({
      :cid => campaign
    })
    ActiveRecord::Base.logger.info "MailChimp campaign sending success: #{sender}"
  end
															
	def self.find_fresh
		Job.find :all, :conditions => ['(expiration > current_date)'], :order => 'expiration'
	end
end