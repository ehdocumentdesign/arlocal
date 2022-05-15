class VideoBuilder


  require 'mediainfo'


  include CatalogHelper


  attr_reader :metadata, :video


  def initialize
    arlocal_settings = (ArlocalSettings === args[:arlocal_settings]) ? args[:arlocal_settings] : nil
    video = (Video === args[:video]) ? args[:video] : Video.new

    @arlocal_settings = arlocal_settings
    @metadata = nil
    @video = video
  end



  protected


  def self.build(**args)
    builder = new
    yield(builder)
    builder.video
  end


  def self.build_with_defaults(**args)
    self.build(**args) do |b|
      b.assign_default_attributes
    end
  end


  def self.create(video_params, **args)
    self.build(**args) do |b|
      b.assign_default_attributes
      b.assign_given_attributes(video_params)
    end
  end



  public


  def assign_default_attributes
    @video.assign_attributes(params_default)
  end


  def assign_given_attributes(video_params)
    @video.assign_attributes(video_params)
  end


  def determine_metadata
    if metadata_is_not_assigned
      case @video.source_type.to_sym
      when :attachment
        determine_metadata_from_attachment
      when :catalog
        determine_metadata_from_catalog
      end
    end
  end


  def determine_metadata_from_attachment
    if @video.recording != nil
      @metadata = MediaInfo.from(@video.recording.blob)
    end
  end


  def determine_metadata_from_catalog
    if File.exists?(catalog_video_filesystem_path(@video))
      @metadata = MediaInfo.from(catalog_video_filesystem_path(@video))
    end
  end


  def metadata_is_assigned
    MediaInfo::Tracks === @metadata
  end


  def metadata_is_not_assigned
    metadata_is_assigned == false
  end


  def read_source_dimensions
    determine_metadata
    @video.source_dimension_height = @metadata.video.height
    @video.source_dimension_width = @metadata.video.width
  end



  private


  def params_default
    {
      copyright_parser_id: MarkupParser.find_by_symbol(:no_formatting).id,
      description_parser_id: MarkupParser.find_by_symbol(:simple_format_rails).id,
      indexed: true,
      involved_people_parser_id: MarkupParser.find_by_symbol(:simple_format_rails).id,
      isrc_country_code: params_default_isrc_country_code,
      isrc_registrant_code: params_default_isrc_registrant_code,
      published: false
    }
  end


  def params_default_isrc_country_code
    if @arlocal_settings
      @arlocal_settings.audio_default_isrc_country_code
    end
  end


  def params_default_isrc_registrant_code
    if @arlocal_settings
      @arlocal_settings.audio_default_isrc_registrant_code
    end
  end


end
