class QueryPictures


  # TODO: Determine which query methods can be deprecated.


  def initialize(args = {})
    arlocal_settings = (ArlocalSettings === args[:arlocal_settings]) ? args[:arlocal_settings] : QueryArlocalSettings.new.get
    @index_sorter_admin = SorterIndexAdminPictures.find(arlocal_settings.admin_index_pictures_sorter_id)
    @index_sorter_public = SorterIndexAdminPictures.find(arlocal_settings.public_index_pictures_sorter_id)
    @selectable_filter = SorterFormSelectablePictures.find(arlocal_settings.admin_forms_selectable_pictures_sorter_id)
    @params = args[:params]

    @pictures = Picture.all.with_attached_image
  end



  public


  def action_admin_edit
    find(@params[:id])
  end


  def action_admin_forms_selectable_pictures
    [PictureBuilder.nil_picture].concat(pictures_admin_forms_selectable)
  end


  def action_admin_index(arg = nil)
    # many of the ordering methods for pictures call upon object instance methods
    # however, originally, ordering methods relied on database attributes.
    # the commented-methods in the following case statement might be obsolete and deprecated.
    filter_method = (arg) ? arg : @params[:filter]

    case filter_method.to_s.downcase
    when 'datetime_asc'
      # order_by_datetime_asc
      @pictures.sort_by{ |p| p.datetime_effective_value }
    when 'datetime_desc'
      # order_by_datetime_desc
      @pictures.sort_by{ |p| p.datetime_effective_value }.reverse
    when 'filepath_asc'
      # order_by_filepath_asc
      @pictures.sort_by{ |p| [p.source_type.to_s, p.source_file_path.to_s] }
    when 'filepath_desc'
      # order_by_filepath_desc
      @pictures.sort_by{ |p| [p.source_type.to_s, p.source_file_path.to_s] }.reverse
    when 'title_asc'
      # order_by_title_asc
      @pictures.sort_by{ |p| p.title_without_markup.downcase }
    when 'title_desc'
      # order_by_title_desc
      @pictures.sort_by{ |p| p.title_without_markup.downcase }.reverse
    else
      all
    end
  end


  # def action_admin_index_by_keyword(keyword, page_number: :all)
  #   pictures = pictures_admin_index_ordered.joins(:keywords).where(keywords: {id: keyword.id})
  #   paginate(page_number: page_number, pictures: pictures)
  # end


  def action_admin_index_by_page(limit: 20, page: 1)
    Picture.paginate(collection: pictures_admin_index_ordered, limit: limit, page: page)
  end


  # def action_admin_index_not_keyworded
  #   find_not_keyworded
  # end


  def action_admin_show
    find(@params[:id])
  end


  def action_admin_show_neighborhood(picture, distance: 1)
    Picture.neighborhood(picture, collection: pictures_admin_index_ordered, distance: distance)
  end


  def action_admin_update
    find(@params[:id])
  end


  # def action_public_album_pictures_index(album)
  #   pictures = album.album_pictures.map { |ap| ap.picture }
  #   paginate(pictures: pictures)
  # end


  def action_public_index(arg = nil)
    # many of the ordering methods for pictures call upon object instance methods
    # however, originally, ordering methods relied on database attributes.
    # the commented-methods in the following case statement might be obsolete and deprecated.
    filter_method = (arg) ? arg : @params[:filter]

    case filter_method.to_s.downcase
    when 'datetime_asc'
      # order_by_datetime_asc.where(indexed: true, published: true)
      @pictures.where(indexed: true, published: true).sort_by{ |p| p.datetime_effective_value }
    when 'datetime_desc'
      # order_by_datetime_desc.where(indexed: true, published: true)
      @pictures.where(indexed: true, published: true).sort_by{ |p| p.datetime_effective_value }.reverse
    when 'filepath_asc'
      # order_by_filepath_asc.where(indexed: true, published: true)
      @pictures.where(indexed: true, published: true).sort_by{ |p| [p.source_type.to_s, p.source_file_path.to_s] }
    when 'filepath_desc'
      # order_by_filepath_desc.where(indexed: true, published: true)
      @pictures.where(indexed: true, published: true).sort_by{ |p| [p.source_type.to_s, p.source_file_path.to_s] }.reverse
    when 'title_asc'
      # order_by_title_asc.where(indexed: true, published: true)
      @pictures.where(indexed: true, published: true).sort_by{ |p| p.title_without_markup.downcase }
    when 'title_desc'
      # order_by_title_desc.where(indexed: true, published: true)
      @pictures.where(indexed: true, published: true).sort_by{ |p| p.title_without_markup.downcase }.reverse
    else
      @pictures.where(indexed: true, published: true)
    end
  end


  def action_public_index_by_page(limit: 20, page: 1)
    Picture.paginate(collection: pictures_public_index_ordered, limit: limit, page: page)
  end


  def action_public_show
    @pictures.where(published: true).find(@params[:id])
  end


  def action_public_show_neighborhood(picture, distance: 1)
    Picture.neighborhood(picture, collection: pictures_public_index_ordered, distance: distance)
  end


  def all
    @pictures.all
  end


  def filter_for_select(arg = nil)
    filter_method = (arg) ? arg : @params[:filter]

    case filter_method.to_s.downcase
    when 'all_title_asc'
      order_by_title_asc
    when 'all_title_desc'
      order_by_title_desc
    when 'only_match_keywords'
      find_with_matching_keywords(nil)
    when 'only_recent_10'
      find_most_recent_title_asc(limit: 10)
    when 'only_recent_20'
      find_most_recent_title_asc(limit: 20)
    when 'only_recent_40'
      find_most_recent_title_asc(limit: 40)
    else
      all
    end
  end


  def find(id)
    @pictures.find(id)
  end


  def find_by_slug(slug)
    @pictures.find_by_slug!(slug)
  end


  def find_by_slug!(slug)
    @pictures.find_by_slug!(slug)
  end


  def find_by_keyword(keyword)
    @pictures.joins(:keywords).where(keywords: {id: keyword.id})
  end


  def find_by_keywords(keywords)
    @pictures.joins(:keywords).where(keywords: {id: keywords.map{|k| k.id} })
  end


  def find_by_keywords_title_asc(keywords)
    @pictures.joins(:keywords).where(keywords: {id: keywords.map{ |k| k.id } }).order(Picture.arel_table[:title_without_markup].lower.asc)
  end


  def find_most_recent(limit: 1)
    @pictures.order(:created_at).limit(limit)
  end


  def find_most_recent_title_asc(limit: 10)
    @pictures.order(:created_at).limit(limit).order(Picture.arel_table[:title_without_markup].lower.asc)
  end


  def find_not_keyworded
    @pictures.where.not(id: Picture.joins(:keywords).each { |k| k.id })
  end


  def order_by_datetime_asc
    # possibly obsolete
    # datetime_effective_value is an object instance method rather than a database attribute
    @pictures.order(datetime_effective_value: :asc)
  end


  def order_by_datetime_desc
    # possibly obsolete
    # datetime_effective_value is an object instance method rather than a database attribute
    @pictures.order(datetime_effective_value: :desc)
  end


  def order_by_filepath_asc
    # possibly obsolete
    @pictures.order(catalog_file_path: :asc)
  end


  def order_by_filepath_desc
    # possibly obsolete
    @pictures.order(catalog_file_path: :desc)
  end


  def order_by_title_asc
    # possibly deprecated
    @pictures.order(Picture.arel_table[:title_without_markup].lower.asc)
  end


  def order_by_title_desc
    # possibly deprecated
    @pictures.order(Picture.arel_table[:title_without_markup].lower.desc)
  end



  private


  def pictures_admin_forms_selectable
    filter_for_select(@selectable_filter.symbol)
  end


  def pictures_admin_index_ordered
    action_admin_index(@index_sorter_admin.symbol)
  end


  def pictures_public_index_ordered
    action_public_index(@index_sorter_public.symbol)
  end


end
