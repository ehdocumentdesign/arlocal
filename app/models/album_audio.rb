class AlbumAudio < ApplicationRecord

  
  belongs_to :album, counter_cache: :audio_count
  belongs_to :audio, counter_cache: :albums_count
  
  
  # === Public Methods
  
  
  # organizes audio into a hash with the album title for the key and an array of audio joined to that album as the value
  def self.album_hash
    track_array = self.all.sort{|a,b| a.album_title.downcase <=> b.album_title.downcase}    
    track_hash = Hash.new { |hash,key| hash[key] = Array.new }

    if track_array.empty?
      track_hash["No tracks"] = []
    else
      track_array.each do |track|
        if track.album
          track_hash[track.album_title.to_s] << track
        else
          track_hash[''] << track
        end
      end
    end
    track_hash
  end


  def self.sort_by_album_title_downcase
    self.all.sort{|a,b| a.audio_title.downcase <=> b.audio_title.downcase}.sort{|a,b| a.album_title.downcase <=> b.album_title.downcase}
  end
  
  
  
  # === Instance Methods  
  
  
  ### album_id
  
  
  ### album_order
  
  
  # wraps album.title to prevent failure if album is nil
  def album_title
    if album
      album.title
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
    if album.index_tracklist_audio_includes_subtitles
      audio_full_title
    else
      audio_title
    end
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
  
  
  def file_source_type
    audio.file_source_type
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
    album_order
  end
  
  
  # alias for audio_title
  def title
    audio_title
  end
  
  
  ### updated_at
  
    
  
end