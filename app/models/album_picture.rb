class AlbumPicture < ApplicationRecord


  belongs_to :album, counter_cache: :pictures_count
  belongs_to :picture, counter_cache: :albums_count


  protected


  def self.sort_by_album_title_downcase
    self.all.sort { |a,b| a.album_title.downcase <=> b.album_title.downcase }
  end



  public


  ### album_id


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
