class EventPicture < ApplicationRecord
  
  
  belongs_to :event, counter_cache: :pictures_count
  belongs_to :picture, counter_cache: :events_count        
  
  
  protected
  
  
  def self.sort_by_event_start_asc
    self.all.sort { |a,b| a.event_start <=> b.event_start }
  end


  def self.sort_by_event_start_desc
    self.all.sort { |a,b| b.event_start <=> a.event_start }
  end


  
  public
  
  
  ### created_at
  
  
  ### event_id
  
  
  # wraps event.id_public to prevent failure if event is nil
  def event_id_public
    if event
      event.id_public
    end
  end
  
  
  ### event_order
   
  
  # wraps event.date_and_venue to prevent failure if event is nil
  def event_date_and_venue
    if event
      event.date_and_venue
    end
  end
    
    
  # wraps event.start_time to prevent failure if event is nil
  def event_start
    if event
      event.start_time
    end
  end
  
  
  ### id
  
  
  def id_public
    id
  end
  
  
  ### is_coverpicture
  
  
  # wraps picture.catalog_file_path to prevent failure if picture is nil  
  def picture_catalog_file_path
    if picture
      picture.catalog_file_path
    end
  end  
  
  
  ### picture_id
  
  
  # wraps picture.id_public to prevent failure if picture is nil  
  def picture_id_public
    if picture
      picture.id_public
    end
  end
    
    
  # wraps picture.slug to prevent failure if picture is nil  
  def picture_slug
    if picture
      picture.slug
    end
  end
  
  
  ### updated_at
  
  
end