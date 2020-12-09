class PictureExifBuilder


  def initialize(picture)
    @picture = picture
  end


  public


  def prepare_from_import
    if File.exists?(picture_catalog_path)
      picture_exif_read(picture_catalog_path)
    end
    return @picture
  end


  def prepare_from_upload
    picture.image.blob.open do |f|
      picture_exif_read(f.path)
    end
    return @picture
  end


  def refresh
    case @picture.file_source_type
    when :attachment
      @picture.image.blob.open do |f|
        picture_exif_read(f.path)
      end
    when :catalog
      if File.exists?(picture_catalog_path)
        picture_exif_read(picture_catalog_path)
      end
    end
    return @picture
  end


  private


  def picture_catalog_path
    File.absolute_path(CatalogHelper.catalog_picture_filesystem_path(@picture))
  end


  def picture_exif_read(path)
    @picture.datetime_from_file = File.ctime(path)
    @picture.datetime_from_exif = Exiftool.new(path)[:date_time_original]
  end


end
