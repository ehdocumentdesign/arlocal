class Public::PicturesController < PublicController


  def index
    if params[:page] || params[:limit]
      index_by_page
    else
      index_all
    end
  end


  def index_all
    @pictures = QueryPictures.index_public(@arlocal_settings, params)
  end


  def index_by_page
    page = QueryPictures.index_public_by_page(@arlocal_settings, params)
    @pictures = page.collection
    @page_nav_data = page.nav_data
    # @selectors = Selectors.new
  end


  def show
    @picture = QueryPictures.find_public(params[:id])
    @picture_neighbors = QueryPictures.neighborhood_public(@picture, @arlocal_settings)
  end


  # def album_pictures_index
  #   @album = QueryAlbums.new.find_by_slug(params[:album_id])
  #   @pictures_page_hash = QueryPictures.new.action_public_album_pictures_index(@album)
  # end

  #
  # def album_pictures_index
  #   @album = QueryAlbums.new.find_by_slug(params[:album_id])
  #   @pictures = QueryPictures.new.action_public_album_pictures_index(@album)
  # end
  #


  # def album_pictures_show
  #   @album = Album.find_by_slug!(params[:album_id])
  #   @picture = Picture.find_by_slug!(params[:id])
  #   @picture_neighbors = @album.pictures_sorted.neighbors_of(@picture)
  # end
  #
  #
  # def event_pictures_index
  #   @event = Event.find_by_slug!(params[:event_id])
  #   @pictures = @event.pictures_sorted
  # end
  #
  #
  # def event_pictures_show
  #   @event = Event.find_by_slug!(params[:event_id])
  #   @picture = Picture.find_by_slug!(params[:id])
  #   @picture_neighbors = @event.pictures_sorted.neighbors_of(@picture)
  # end


  # def index_by_keyword
  #   @keyword = Keyword.find_by_slug!(params[:keyword_id])
  #   @pictures_page_hash = pictures_sorted_by_arlocal_settings.with_keyword_matching(keyword_id: @keyword.id).organize_as_page(page_number: params[:page])
  #   @selectors = { keywords: Keyword.all_that_select_pictures.order_by_title_asc }
  #   render action: :index
  # end
  #
  #
  # def index_not_keywordged
  #   @pictures_page_hash = pictures_sorted_by_arlocal_settings.not_keywordged.organize_as_page(page_number: params[:page])
  #   @selectors = { keywords: Keyword.all_that_select_pictures.order_by_title_asc }
  #   render action: :index
  # end


  # class Selectors
  #   attr_reader(
  #     :keywords
  #   )
  #   def initialize
  #     @keywords = QueryKeywords.new.all_that_select_public_pictures
  #   end
  # end


end
