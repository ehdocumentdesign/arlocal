class VideoPicture < ApplicationRecord


  belongs_to :video
  belongs_to :picture


  protected


  def self.sort_by_video_title_downcase
    self.all.sort { |a,b| a.video_title.downcase <=> b.video_title.downcase }
  end



  public


  ### video_id


  # wraps video.id_public to prevent failure if video is nil
  def video_id_public
    if video
      video.id_public
    end
  end


  # wraps video.title to prevent failure if video is nil
  def video_title
    if video
      video.title
    end
  end


  ### created_at


  ### id


  def id_public
    id
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


  # wraps picture.source_file_path to prevent failure if picture is nil
  def picture_source_file_path
    if picture
      picture.source_file_path
    end
  end


  ### updated_at


end
