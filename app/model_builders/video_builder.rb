class VideoBuilder


  require 'mediainfo'


  attr_reader :video


  PARAMS_DEFAULT = {
    copyright_parser_id: MarkupParser.find_by_symbol(:no_formatting).id,
    description_parser_id: MarkupParser.find_by_symbol(:markdown_commonmarker).id,
    indexed: true,
    involved_people_parser_id: MarkupParser.find_by_symbol(:markdown_commonmarker).id,
    published: false
  }


  def self.build
    builder = new
    yield(builder)
    builder.video
  end


  def initialize
    @video = Video.new
  end


  def assign_default_attributes
    @video.assign_attributes(PARAMS_DEFAULT)
  end


  def find_existing_attributes(id)
    @video = Video.find(id)
  end


  def assign_given_attributes(video_params)
    @video.assign_attributes(video_params)
  end


  def read_source_dimensions
    case @video.source_type.to_sym
    when :attachment
      read_source_dimensions_attachment
    when :catalog
      read_source_dimensions_catalog
    end
  end


  def read_source_dimensions_attachment
    if @video.recording != nil
      mediainfo = MediaInfo.from(@video.recording.blob)
      @video.source_dimension_height = mediainfo.video.height
      @video.source_dimension_width = mediainfo.video.width
    end
  end


  def read_source_dimensions_catalog
    if File.exists?(CatalogHelper.catalog_video_filesystem_path(@video))
      mediainfo = MediaInfo.from(CatalogHelper.catalog_video_filesystem_path(@video))
      @video.source_dimension_height = mediainfo.video.height
      @video.source_dimension_width = mediainfo.video.width
    end
  end


end
