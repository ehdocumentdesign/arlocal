class AudioKeyword < ApplicationRecord

  belongs_to :audio, counter_cache: :keywords_count
  belongs_to :keyword, counter_cache: :audio_count  

  
  # === Instance Methods  
  

  ### audio_id


  # wraps audio.full_title to prevent failure if audio is nil
  def audio_full_title
    if audio
      audio.full_title
    end
  end
  
    
  # wraps audio.id_public to prevent failure if audio is nil
  def audio_id_public
    if audio
      audio.id_public
    end
  end


  # wraps audio.title to prevent failure if audio is nil
  def audio_title
    if audio
      audio.title
    end
  end
    
  
  ### created_at
  
  
  # unique index id for database
  ### id
  
  
  def id_public
    id
  end


  ### keyword_id
  
  
  # wraps keyword.title to prevent failure if keyword is nil
  def keyword_title
    if keyword
      keyword.title
    end
  end
    

  ### updated_at

    
end
