months = { january: 31, february: 28, march: 31, april: 30, may: 31, june: 30, july: 31, august: 31, september: 30, october: 31, november: 30, december: 31}

months.each do |months, days|
  if days == 30
    puts "#{months}: #{days} days"
  end
end