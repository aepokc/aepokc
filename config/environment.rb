# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Aepokc::Application.initialize!

Date::DATE_FORMATS[:formatted_date] = "%A, %B %d, %Y"
Time::DATE_FORMATS[:formatted_time] = "%I:%M %p"