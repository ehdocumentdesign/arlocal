module Calendar
  
  
  def self.by_year(events)
    result = Hash.new{ |year, event_array| year[event_array] = Array.new }
    events.each do |event|
      year = event.datetime_year.to_s
      result[year] << event
    end
    result
  end


  def self.raw(events)
    result = Hash.new{ |year, event_array| year[event_array] = Array.new }
    events.each do |event|
      year = event.datetime_year.to_s
      result[''] << event
    end
    result
  end
  
  
end
    
  