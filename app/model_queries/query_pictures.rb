class QueryPictures


  # TODO: Commented-out methods are from a previous factoring. They might be useful for future reference.


  def initialize(**args)
    arlocal_settings = (ArlocalSettings === args[:arlocal_settings]) ? args[:arlocal_settings] : QueryArlocalSettings.new.get
    @index_sorter_admin = SorterIndexAdminPictures.find(arlocal_settings.admin_index_pictures_sorter_id)
    @index_sorter_public = SorterIndexAdminPictures.find(arlocal_settings.public_index_pictures_sorter_id)
    @selectable_filter = SorterFormSelectablePictures.find(arlocal_settings.admin_forms_selectable_pictures_sorter_id)
    @params = args[:params]
  end



  public


  def action_admin_edit
    pictures.friendly.find(@params[:id])
  end


  def action_admin_forms_selectable_pictures
    [PictureBuilder.nil_picture].concat(pictures_admin_forms_selectable)
  end


  def action_admin_index(arg = nil)
    filter_method = (arg) ? arg : @params[:filter]
    case filter_method.to_s.downcase
    when 'datetime_asc'
      pictures.sort_by{ |p| p.datetime_effective_value }
    when 'datetime_desc'
      pictures.sort_by{ |p| p.datetime_effective_value }.reverse
    when 'filepath_asc'
      pictures.sort_by{ |p| [p.source_type.to_s, p.source_file_path.to_s] }
    when 'filepath_desc'
      pictures.sort_by{ |p| [p.source_type.to_s, p.source_file_path.to_s] }.reverse
    when 'title_asc'
      pictures.sort_by{ |p| p.title_without_markup.downcase }
    when 'title_desc'
      pictures.sort_by{ |p| p.title_without_markup.downcase }.reverse
    else
      pictures
    end
  end


  def action_admin_index_by_page(limit: 20, page: 1)
    Picture.paginate(collection: pictures_admin_index_ordered, limit: limit, page: page)
  end


  def action_admin_show
    pictures.friendly.find(@params[:id])
  end


  def action_admin_show_neighborhood(picture, distance: 1)
    Picture.neighborhood(picture, collection: pictures_admin_index_ordered, distance: distance)
  end


  def action_admin_update
    pictures.friendly.find(@params[:id])
  end


  def action_public_index(arg = nil)
    filter_method = (arg) ? arg : @params[:filter]
    case filter_method.to_s.downcase
    when 'datetime_asc'
      pictures.where(indexed: true, published: true).sort_by{ |p| p.datetime_effective_value }
    when 'datetime_desc'
      pictures.where(indexed: true, published: true).sort_by{ |p| p.datetime_effective_value }.reverse
    when 'filepath_asc'
      pictures.where(indexed: true, published: true).sort_by{ |p| [p.source_type.to_s, p.source_file_path.to_s] }
    when 'filepath_desc'
      pictures.where(indexed: true, published: true).sort_by{ |p| [p.source_type.to_s, p.source_file_path.to_s] }.reverse
    when 'title_asc'
      pictures.where(indexed: true, published: true).sort_by{ |p| p.title_without_markup.downcase }
    when 'title_desc'
      pictures.where(indexed: true, published: true).sort_by{ |p| p.title_without_markup.downcase }.reverse
    else
      pictures.where(indexed: true, published: true)
    end
  end


  def action_public_index_by_page(limit: 20, page: 1)
    Picture.paginate(collection: pictures_public_index_ordered, limit: limit, page: page)
  end


  def action_public_show
    pictures.where(published: true).friendly.find(@params[:id])
  end


  def action_public_show_neighborhood(picture, distance: 1)
    Picture.neighborhood(picture, collection: pictures_public_index_ordered, distance: distance)
  end


  def filter_for_select(arg = nil)
    filter_method = (arg) ? arg : @params[:filter]
    case filter_method.to_s.downcase
    when 'all_title_asc'
      pictures.where(indexed: true, published: true).sort_by{ |p| p.title_without_markup.downcase }
    when 'all_title_desc'
      pictures.where(indexed: true, published: true).sort_by{ |p| p.title_without_markup.downcase }.reverse
    when 'only_match_keywords'
      pictures.joins(:keywords).where(keywords: {id: keywords.map{|k| k.id} })
    when 'only_recent_10'
      pictures.order(:created_at).limit(10).order(Picture.arel_table[:title_without_markup].lower.asc)
    when 'only_recent_20'
      pictures.order(:created_at).limit(20).order(Picture.arel_table[:title_without_markup].lower.asc)
    when 'only_recent_40'
      pictures.order(:created_at).limit(40).order(Picture.arel_table[:title_without_markup].lower.asc)
    else
      pictures
    end
  end


  # def find(id)
  #   pictures.friendly.find(id)
  # end
  #
  #
  # def find_by_slug(slug)
  #   pictures.friendly.find(id)
  # end
  #
  #
  # def find_by_slug!(slug)
  #   pictures.friendly.find(id)
  # end
  #
  #
  # def find_by_keyword(keyword)
  #   pictures.joins(:keywords).where(keywords: {id: keyword.id})
  # end
  #
  #
  # def find_by_keywords(keywords)
  #   pictures.joins(:keywords).where(keywords: {id: keywords.map{|k| k.id} })
  # end
  #
  #
  # def find_by_keywords_title_asc(keywords)
  #   pictures.joins(:keywords).where(keywords: {id: keywords.map{ |k| k.id } }).order(Picture.arel_table[:title_without_markup].lower.asc)
  # end
  #
  #
  # def find_most_recent(limit: 1)
  #   pictures.order(:created_at).limit(limit)
  # end
  #
  #
  # def find_most_recent_title_asc(limit: 10)
  #   pictures.order(:created_at).limit(limit).order(Picture.arel_table[:title_without_markup].lower.asc)
  # end
  #
  #
  # def find_not_keyworded
  #   pictures.where.not(id: Picture.joins(:keywords).each { |k| k.id })
  # end
  #
  #


  private


  def pictures
    Picture.all.with_attached_image
  end


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
