class EventAudio < ApplicationRecord
  
  
  belongs_to :event, counter_cache: :audio_count
  belongs_to :audio, counter_cache: :events_count
  
  
  # === Public Methods
  
  
  # organizes audio into a hash with the event title for the key and an array of audio joined to that event as the value
  def self.event_hash
    track_array = self.all.sort{|a,b| a.event_title.downcase <=> b.event_title.downcase}    
    track_hash = Hash.new { |hash,key| hash[key] = Array.new }

    if track_array.empty?
      track_hash["No tracks"] = []
    else
      track_array.each do |track|
        if track.event
          track_hash[track.event_title.to_s] << track
        else
          track_hash[''] << track
        end
      end
    end
    track_hash
  end


  def self.sort_by_event_title_downcase
    self.all.sort{|a,b| a.audio_title.downcase <=> b.audio_title.downcase}.sort{|a,b| a.event_title.downcase <=> b.event_title.downcase}
  end
  
  
  
  # === Instance Methods  
  
  
  ### event_id
  
  
  ### event_order
  
  
  # wraps event.title to prevent failure if event is nil
  def event_title
    if event
      event.title
    end
  end


  # wraps audio.file_basename to prevent failure if audio is nil
  def audio_file_basename
    if audio
      audio.file_basename
    end
  end
  
  
  # wraps audio.full_title to prevent failure if audio is nil
  def audio_full_title
    if audio
      audio.full_title
    end
  end
  

  ### audio_id


  # wraps audio.title to prevent failure if audio is nil
  def audio_title
    if audio
      audio.title
    end
  end

  
  def catalog_file_path
    audio.catalog_file_path
  end

  
  ### created_at
  
  
  def display_title
    # if event.index_tracklist_audio_includes_subtitles
    #   audio_full_title
    # else
    #   audio_title
    # end
    audio_title
  end


  def duration
    duration_as_text
  end
  
  
  # wraps audio.duration_as_text to prevent failure if audio is nil
  def duration_as_text
    if audio
      audio.duration_as_text
    end
  end


  # alias for audio_file_basename
  def file_basename
    audio_file_basename
  end
    
  
  # alias for audio_full_title
  def full_title
    audio_full_title
  end
  
  
  # unique index id for database
  ### id
  
  
  def id_public
    id
  end
  
  
  def playlist_order
    event_order
  end
  
  
  # alias for audio_title
  def title
    audio_title
  end
  
  
  ### updated_at
  
    
  
end