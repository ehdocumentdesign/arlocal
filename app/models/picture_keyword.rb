class PictureKeyword < ApplicationRecord

  
  belongs_to :picture, counter_cache: :keywords_count
  belongs_to :keyword, counter_cache: :pictures_count


  public


  ### created_at


  ### id


  def id_public
    id
  end


  # wraps self.picture.catalog_file_path to prevent failure if self.picture is nil
  def picture_catalog_file_path
    if picture
      picture.catalog_file_path
    end
  end


  ### picture_id


  # wraps self.picture.id_public to prevent failure if self.picture is nil
  def picture_id_public
    if picture
      picture.id_public
    end
  end


  # wraps self.picture.slug to prevent failure if self.picture is nil
  def picture_slug
    if picture
      picture.slug
    end
  end


  ### keyword_id


  # wraps self.keyword.id_public to prevent failure if self.keyword is nil
  def keyword_id_public
    if keyword
      keyword.id_public
    end
  end


  # wraps self.keyword.title to prevent failure if self.keyword is nil
  def keyword_title
    if keyword
      keyword.title
    end
  end


  ### updated_at


end
