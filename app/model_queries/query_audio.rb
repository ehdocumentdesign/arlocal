class QueryAudio


  def initialize(args = {})
    arlocal_settings = (ArlocalSettings === args[:arlocal_settings]) ? args[:arlocal_settings] : QueryArlocalSettings.new.get
    @index_sorter_admin = SorterIndexAdminAudio.find(arlocal_settings.admin_index_audio_sorter_id)
    @index_sorter_public = SorterIndexAdminAudio.find(arlocal_settings.public_index_audio_sorter_id)

    @audio = Audio.all.with_attached_recording
  end



  public


  def action_admin_index(arg = nil)
    filter_method = (arg) ? arg : @params[:filter]

    case filter_method.to_s.downcase
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
      all
    end
  end


  def action_admin_index_by_keyword(keyword)
    @audio.joins(:keywords).where(keywords: {id: keyword.id}).order(title: :asc)
  end


  def action_admin_index_no_albums
    @audio.where.not(id: Audio.joins(:albums).map {|aa| aa.id}).order(title: :asc)
  end


  def action_admin_index_no_keywords
    @audio.where.not(id: Audio.joins(:keywords).map {|ak| ak.id}).order(title: :asc)
  end


  def action_admin_show_neighborhood(audio, distance: 1)
    Audio.neighborhood(audio, collection: audio_admin_index_ordered, distance: distance)
  end


  def action_public_index
    all.where(indexed: true, published: true)
  end


  def all
    @audio.all
  end


  def find(id)
    @audio.find_by_id!(id)
  end


  def find!(id)
    @audio.find_by_id!(id)
  end


  def find_by_album(album)
    @audio.joins(:albums).where(albums: {id: album.id}).order(title: :asc)
  end


  def find_by_keyword(keyword)
    @audio.joins(:keywords).where(keywords: {id: keyword.id})
  end


  def order_by_date_released_asc
    @audio.order(date_released: :asc).order(catalog_file_path: :asc)
  end


  def order_by_date_released_desc
    @audio.order(date_released: :desc).order(catalog_file_path: :asc)
  end


  def order_by_filepath_asc
    @audio.order(source_file_path: :asc)
  end


  def order_by_filepath_desc
    @audio.order(source_file_path: :desc)
  end


  def order_by_isrc_asc
    @audio.order(isrc_country_code: :asc).order(isrc_registrant_code: :asc).order(isrc_year_of_reference: :asc).order(isrc_designation_code: :asc)
  end


  def order_by_isrc_desc
    @audio.order(isrc_country_code: :desc).order(isrc_registrant_code: :desc).order(isrc_year_of_reference: :desc).order(isrc_designation_code: :desc)
  end


  def order_by_title_asc
    @audio.order(Audio.arel_table[:title].lower.asc)
  end


  def order_by_title_desc
    @audio.order(Audio.arel_table[:title].lower.desc)
  end



  private


  def audio_admin_index_ordered
    action_admin_index(@index_sorter_admin.symbol)
  end


  def audio_public_index_ordered
    action_public_index(@index_sorter_public.symbol)
  end


end
