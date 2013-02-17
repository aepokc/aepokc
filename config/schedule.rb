every :weekday, :at => '1:00 pm' do
  rake 'members:remind'
end

every :weekday, :at => '4:00 pm' do
  rake 'members:invoice'
end