class QueryPictures


  # Controllers call a singleton method to maintain the look and feel of
  # the ActiveRecord Query Interface.
  #
  # If a singleton menthod requires interpretation of data, such as
  # ArlocalSettings or request parameters, the singleton method will create an
  # instance object and call a corresponding instance method.



  protected


  def self.find_admin(id)
    Picture.friendly.find(id)
  end


  def self.find_public(id)
    Picture.where(published: true).friendly.find(id)
  end


  def self.find_with_keyword(keyword)
    Picture.joins(:keywords).where(keywords: {id: keyword.id})
  end


  def self.index_admin(arlocal_settings, params)
    new(arlocal_settings: arlocal_settings, params: params).index_admin
  end


  def self.index_admin_by_page(arlocal_settings, params)
    new(arlocal_settings: arlocal_settings, params: params).index_admin_by_page
  end


  def self.index_public(arlocal_settings, params)
    new(arlocal_settings: arlocal_settings, params: params).index_public
  end


  def self.index_public_by_page(arlocal_settings, params)
    new(arlocal_settings: arlocal_settings, params: params).index_public_by_page
  end


  def self.neighborhood_admin(picture, arlocal_settings)
    new(arlocal_settings: arlocal_settings).neighborhood_admin(picture)
  end


  def self.neighborhood_public(picture, arlocal_settings)
    new(arlocal_settings: arlocal_settings).neighborhood_public(picture)
  end



  def self.options_for_select_admin(arlocal_settings)
    new(arlocal_settings: arlocal_settings).options_for_select_admin
  end


  def self.options_for_select_admin_with_nil(arlocal_settings)
    new(arlocal_settings: arlocal_settings).options_for_select_admin_with_nil
  end



  public


  def initialize(**args)
    @arlocal_settings = args[:arlocal_settings]
    @params = args[:params] ? args[:params] : {}
  end





  def all
    all_pictures
  end


  def index_admin
    case determine_filter_method_admin
    when 'datetime_asc'
      all_pictures.sort_by{ |p| p.datetime_effective_value }
    when 'datetime_desc'
      all_pictures.sort_by{ |p| p.datetime_effective_value }.reverse
    when 'filepath_asc'
      all_pictures.sort_by{ |p| [p.source_type.to_s, p.source_file_path.to_s] }
    when 'filepath_desc'
      all_pictures.sort_by{ |p| [p.source_type.to_s, p.source_file_path.to_s] }.reverse
    when 'title_asc'
      all_pictures.sort_by{ |p| p.title_without_markup.downcase }
    when 'title_desc'
      all_pictures.sort_by{ |p| p.title_without_markup.downcase }.reverse
    else
      all_pictures
    end
  end


  def index_admin_by_page
    Picture.paginate(collection: index_admin, limit: @params[:limit], page: @params[:page])
  end


  def index_public
    case determine_filter_method_public
    when 'datetime_asc'
      all_pictures.where(indexed: true, published: true).sort_by{ |p| p.datetime_effective_value }
    when 'datetime_desc'
      all_pictures.where(indexed: true, published: true).sort_by{ |p| p.datetime_effective_value }.reverse
    when 'filepath_asc'
      all_pictures.where(indexed: true, published: true).sort_by{ |p| [p.source_type.to_s, p.source_file_path.to_s] }
    when 'filepath_desc'
      all_pictures.where(indexed: true, published: true).sort_by{ |p| [p.source_type.to_s, p.source_file_path.to_s] }.reverse
    when 'title_asc'
      all_pictures.where(indexed: true, published: true).sort_by{ |p| p.title_without_markup.downcase }
    when 'title_desc'
      all_pictures.where(indexed: true, published: true).sort_by{ |p| p.title_without_markup.downcase }.reverse
    else
      all_pictures.where(indexed: true, published: true)
    end
  end


  def index_public_by_page
    Picture.paginate(collection: index_public, limit: @params[:limit], page: @params[:page])
  end


  def neighborhood_admin(picture, distance: 1)
    Picture.neighborhood(picture, collection: index_admin, distance: distance)
  end


  def neighborhood_public(picture, distance: 1)
    Picture.neighborhood(picture, collection: index_public, distance: distance)
  end


  def options_for_select_admin
    case determine_filter_method_form_selectable
    when 'all_title_asc'
      all_pictures.sort_by{ |p| p.title_without_markup.downcase }
    when 'all_title_desc'
      all_pictures.sort_by{ |p| p.title_without_markup.downcase }.reverse
    when 'only_match_keywords'
      all_pictures.joins(:keywords).where(keywords: {id: keywords.map{|k| k.id} })
    when 'only_recent_10'
      all_pictures.order(:created_at).limit(10).order(Picture.arel_table[:title_without_markup].lower.asc)
    when 'only_recent_20'
      all_pictures.order(:created_at).limit(20).order(Picture.arel_table[:title_without_markup].lower.asc)
    when 'only_recent_40'
      all_pictures.order(:created_at).limit(40).order(Picture.arel_table[:title_without_markup].lower.asc)
    else
      all_pictures
    end
  end


  def options_for_select_admin_with_nil
    [PictureBuilder.nil_picture, options_for_select_admin].flatten
  end



  private


  def all_pictures
    Picture.all.with_attached_image
  end


  def determine_filter_method_admin
    if @params[:filter]
      @params[:filter].downcase
    else
      index_sorter_admin.symbol.to_s.downcase
    end
  end


  def determine_filter_method_form_selectable
    index_sorter_form_selectable.symbol.to_s.downcase
  end


  def determine_filter_method_public
    if @params[:filter]
      @params[:filter].downcase
    else
      index_sorter_public.symbol.to_s.downcase
    end
  end


  def index_sorter_admin
    SorterIndexAdminPictures.find(@arlocal_settings.admin_index_pictures_sorter_id)
  end


  def index_sorter_form_selectable
    SorterFormSelectablePictures.find(@arlocal_settings.admin_forms_selectable_pictures_sorter_id)
  end


  def index_sorter_public
    SorterIndexPublicPictures.find(@arlocal_settings.public_index_pictures_sorter_id)
  end


end
