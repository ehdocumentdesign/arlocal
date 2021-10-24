class QueryAudio


  protected


  def self.find_admin(id)
    Audio.friendly.find(id)
  end


  def self.find_public(id)
    Audio.where(published: true).friendly.find(id)
  end


  def self.find_with_keyword(keyword)
    Audio.joins(:keywords).where(keywords: {id: keyword.id})
  end


  def self.index_admin(arlocal_settings, params)
    new(arlocal_settings: arlocal_settings, params: params).index_admin
  end


  def self.index_public(arlocal_settings, params)
    new(arlocal_settings: arlocal_settings, params: params).index_public
  end


  def self.neighborhood_admin(audio, arlocal_settings)
    new(arlocal_settings: arlocal_settings).neighborhood_admin(audio)
  end


  def self.neighborhood_public(audio, arlocal_settings)
    new(arlocal_settings: arlocal_settings).neighborhood_public(audio)
  end


  def self.options_for_select_admin
    new.order_by_title_asc
  end



  public


  def initialize(**args)
    @arlocal_settings = args[:arlocal_settings]
    @params = args[:params] ? args[:params] : {}
  end


  def all
    all_audio
  end


  def index_admin(arg = nil)
    case determine_filter_method_admin
    when 'datetime_asc'
      order_by_date_released_asc
    when 'datetime_desc'
      order_by_date_released_desc
    when 'filepath_asc'
      order_by_filepath_asc
    when 'filepath_desc'
      order_by_filepath_desc
    when 'isrc_asc'
      order_by_isrc_asc
    when 'isrc_desc'
      order_by_isrc_desc
    when 'title_asc'
      order_by_title_asc
    when 'title_desc'
      order_by_title_desc
    else
      all_audio
    end
  end


  def index_public
    all_audio.where(indexed: true, published: true)
  end


  def neighborhood_admin(audio, distance: 1)
    Audio.neighborhood(audio, collection: index_admin, distance: distance)
  end


  def neighborhood_public(audio, distance: 1)
    Audio.neighborhood(audio, collection: index_public, distance: distance)
  end


  def order_by_date_released_asc
    all_audio.order(date_released: :asc).order(catalog_file_path: :asc)
  end


  def order_by_date_released_desc
    all_audio.order(date_released: :desc).order(catalog_file_path: :asc)
  end


  def order_by_filepath_asc
    all_audio.order(source_file_path: :asc)
  end


  def order_by_filepath_desc
    all_audio.order(source_file_path: :desc)
  end


  def order_by_isrc_asc
    all_audio.order(isrc_country_code: :asc).order(isrc_registrant_code: :asc).order(isrc_year_of_reference: :asc).order(isrc_designation_code: :asc)
  end


  def order_by_isrc_desc
    all_audio.order(isrc_country_code: :desc).order(isrc_registrant_code: :desc).order(isrc_year_of_reference: :desc).order(isrc_designation_code: :desc)
  end


  def order_by_title_asc
    all_audio.order(Audio.arel_table[:title].lower.asc)
  end


  def order_by_title_desc
    all_audio.order(Audio.arel_table[:title].lower.desc)
  end



  private


  def all_audio
    Audio.all.with_attached_source_attachment
  end


  def determine_filter_method_admin
    if @params[:filter]
      @params[:filter].downcase
    else
      index_sorter_admin.symbol.to_s.downcase
    end
  end


  def determine_filter_method_public
    if @params[:filter]
      @params[:filter].downcase
    else
      index_sorter_public.symbol.to_s.downcase
    end
  end


  def index_sorter_admin
    SorterIndexAdminAudio.find(@arlocal_settings.admin_index_audio_sorter_id)
  end


  def index_sorter_public
    SorterIndexPublicAudio.find(@arlocal_settings.public_index_audio_sorter_id)
  end


end


#
# def self.find_by_keyword(keyword)
#   Audio.all.with_attached_recording.joins(:keywords).where(keywords: {id: keyword.id})
# end
#


#
# def index_by_keyword(keyword)
#   all_audio.joins(:keywords).where(keywords: {id: keyword.id}).order(title: :asc)
# end
#
#
# def index_by_albums_none
#   all_audio.where.not(id: Audio.joins(:albums).map {|aa| aa.id}).order(title: :asc)
# end
#
#
# def index_no_keywords
#   all_audio.where.not(id: Audio.joins(:keywords).map {|ak| ak.id}).order(title: :asc)
# end
#
#
# def find(id)
#   all_audio.friendly.find(id)
# end
#
#
# def find_by_album(album)
#   all_audio.joins(:albums).where(albums: {id: album.id}).order(title: :asc)
# end
#
#
# def find_by_keyword(keyword)
#   all_audio.joins(:keywords).where(keywords: {id: keyword.id})
# end
