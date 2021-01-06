class VideoBuilder


  require 'mediainfo'


  attr_reader :video


  def self.build
    builder = new
    yield(builder)
    builder.video
  end


  def initialize
    @mediainfo = nil
    @video = Video.new
  end


  def assign_default_attributes
    @video.assign_attributes(params_default)
  end


  def assign_given_attributes(video_params)
    @video.assign_attributes(video_params)
  end


  def find_preexisting(id)
    @video = Video.find(id)
  end


  def read_source_dimensions
    determine_mediainfo
    @video.source_dimension_height = @mediainfo.video.height
    @video.source_dimension_width = @mediainfo.video.width
  end



  private


  def determine_mediainfo
    if mediainfo_is_not_assigned
      case @video.source_type.to_sym
      when :attachment
        determine_mediainfo_from_attachment
      when :catalog
        determine_mediainfo_from_catalog
      end
    end
  end


  def determine_mediainfo_from_attachment
    if @video.recording != nil
      @mediainfo = MediaInfo.from(@video.recording.blob)
    end
  end


  def determine_mediainfo_from_catalog
    if File.exists?(CatalogHelper.catalog_video_filesystem_path(@video))
      @mediainfo = MediaInfo.from(CatalogHelper.catalog_video_filesystem_path(@video))
    end
  end


  def mediainfo_is_assigned
    MediaInfo::Tracks === @mediainfo
  end


  def mediainfo_is_not_assigned
    mediainfo_is_assigned == false
  end


  def params_default
    {
      copyright_parser_id: MarkupParser.find_by_symbol(:no_formatting).id,
      description_parser_id: MarkupParser.find_by_symbol(:markdown_commonmarker).id,
      indexed: true,
      involved_people_parser_id: MarkupParser.find_by_symbol(:markdown_commonmarker).id,
      published: false
    }
  end


end
