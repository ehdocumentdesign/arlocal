module VideoBuilder


  require 'mediainfo'


  PARAMS_DEFAULT = {
    copyright_parser_id: MarkupParser.find_by_symbol(:no_formatting).id,
    description_parser_id: MarkupParser.find_by_symbol(:markdown_commonmarker).id,
    indexed: false,
    involved_people_parser_id: MarkupParser.find_by_symbol(:markdown_commonmarker).id,
    published: false
  }


  module_function


  def default
    Video.new(PARAMS_DEFAULT)
  end


  def default_with(params_given)
    params = PARAMS_DEFAULT.merge(params_given)
    Video.new(params)
  end


  def read_source_dimensions(video)
    case video.source_type.to_sym
    when :attachment
      if video.recording != nil
        mediainfo = MediaInfo.from(video.recording.blob)
        video.source_dimension_height = mediainfo.video.height
        video.source_dimension_width = mediainfo.video.width
      end
    when :catalog
      if File.exists?(CatalogHelper.catalog_video_filesystem_path(video))
        mediainfo = MediaInfo.from(CatalogHelper.catalog_video_filesystem_path(video))
        video.source_dimension_height = mediainfo.video.height
        video.source_dimension_width = mediainfo.video.width
      end
    end
    return video
  end


end
