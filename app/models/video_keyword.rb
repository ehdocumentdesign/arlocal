class VideoKeyword < ApplicationRecord


  belongs_to :video, counter_cache: :keywords_count
  belongs_to :keyword, counter_cache: :videos_count


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


  ### updated_at


  # wraps keyword.title to prevent failure if keyword is nil
  def keyword_title
    if keyword
      keyword.title
    end
  end


end
