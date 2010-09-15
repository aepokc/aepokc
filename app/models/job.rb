class Job < ActiveRecord::Base

	belongs_to :member

	validates_format_of :phone, :with => /[1-9][0-9]{9}/, :message => "- please supply the phone number in the following format: 4058182257"

end
