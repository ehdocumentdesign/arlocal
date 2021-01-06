class AlbumKeyword < ApplicationRecord


  belongs_to :album, counter_cache: :keywords_count
  belongs_to :keyword, counter_cache: :albums_count


  # wraps album.id_public to prevent failure if album is nil
  def album_id_public
    if album
      album.id_public
    end
  end


  # wraps album.title to prevent failure if album is nil
  def album_title
    if album
      album.title
    end
  end


  ### created_at


  ### id


  def id_public
    id
  end

  ### updated_at


  # wraps keyword.title to prevent failure if keyword is nil
  def keyword_title
    if keyword
      keyword.title
    end
  end


end
