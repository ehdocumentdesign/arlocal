class EventKeyword < ApplicationRecord
  
  belongs_to :event, counter_cache: :keywords_count
  belongs_to :keyword, counter_cache: :events_count
  

  # === Instance Methods  
  
  
  ### created_at
  
  
  ### event_id

    
  # wraps self.event.id_public to prevent failure if self.event is nil  
  def event_id_public
    if event
      event.id_public
    end
  end
  
  
  # wraps event.date_and_venue to prevent failure if event is nil  
  def event_date_and_venue
    if event
      event.date_and_venue
    end
  end
  
  
  # unique index id for database
  ### id
  
  
  def id_public
    id
  end
  

  ### keyword_id

  
  # wraps keyword.id_public to prevent failure if keyword is nil  
  def keyword_id_public
    if keyword
      keyword.id_public
    end
  end
  
  
  # wraps keyword.title to prevent failure if keyword is nil  
  def keyword_title
    if keyword
      keyword.title
    end
  end
  
  
  ### updated_at

    
end