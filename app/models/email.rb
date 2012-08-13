class Email < ActiveRecord::Base
  has_and_belongs_to_many :events
  attr_accessible :from_name, :reply_to, :subject_line, :recipients, :title, :preface, :html, :event_ids
  
  def parse_events(raw_ids)
    array_of_strings = raw_ids.split(',')
    array_of_integers = []
    array_of_strings.each do |s|
      array_of_integers.push(s.to_i)
    end
    self.event_ids = array_of_integers
  end
  
  def send_from_mailchimp
    url = 'http://aepokc.com/emails/'+self.id.to_s
    campaign = Gibbon.campaign_create({
      :type => 'regular',
      :options => ({
        :list_id => self.recipients,
        :subject => self.subject_line,
        :from_email => self.reply_to,
        :from_name => self.from_name,
        :title => self.title,
#        :auto_tweet => true
      }),
      :content => ({
        :url => url,
        :text => 'Just letting you know that upcoming aep events have been announced at '+url
      })
    })
    ActiveRecord::Base.logger.info "MailChimp campaign creation response: #{campaign}"
    sender = Gibbon.campaign_send_now({
      :cid => campaign
    })
    ActiveRecord::Base.logger.info "MailChimp campaign sending success: #{sender}"
  end
end
