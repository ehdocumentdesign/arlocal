class Admin::PicturesController < AdminController


  # def album_pictures_index
  #   @album = QueryAlbums.new.find_by_slug(params[:album_id])
  #   @pictures_page_hash = QueryPictures.new.album_pictures_index(@album)
  # end
  #
  #
  # def album_pictures_show
  #   @album = QueryAlbums.new.find_by_slug(params[:album_id])
  #   @picture = QueryPictures.new.find_by_slug(params[:id])
  #   @picture_neighbors = @album.pictures_sorted.neighbors_of(@picture)
  # end
  #
  #
  # def event_pictures_index
  #   @event = QueryEvents.new.find_by_slug(params[:event_id])
  #   @pictures = @event.pictures_sorted
  # end
  #
  #
  # def event_pictures_show
  #   @event = QueryEvents.new.find_by_slug(params[:event_id])
  #   @picture = QueryPictures.new.find_by_slug(params[:id])
  #   @picture_neighbors = @event.pictures_sorted.neighbors_of(@picture)
  # end


  def create
    @picture = PictureBuilder.create(picture_params)
    if @picture.save
      flash[:notice] = 'Picture was successfuly created.'
      redirect_to edit_admin_picture_path(@picture.id_admin)
    else
      @form_metadata = FormPictureMetadata.new
      if @arlocal_settings.admin_forms_auto_keyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      flash[:notice] = 'Picture could not be created.'
      render 'new'
    end
  end


  def create_from_import
    @picture = PictureBuilder.create_from_import(picture_params)
    if @picture.save
      flash[:notice] = 'Picture was successfully imported.'
      redirect_to edit_admin_picture_path(@picture.id_admin)
    else
      @form_metadata = FormPictureMetadata.new
      if @arlocal_settings.admin_forms_auto_keyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      flash[:notice] = 'Picture could not be imprted.'
      render 'new_import'
    end
  end


  def create_from_import_to_album
    @picture = PictureBuilder.create_from_import_and_join_nested_album(picture_params)
    if @picture.save
      flash[:notice] = 'Picture was successfully imported.'
      redirect_to edit_admin_picture_path(@picture.id_admin)
    else
      if @arlocal_settings.admin_forms_auto_keyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      @albums = QueryAlbums.new.order_by_title_asc
      flash[:notice] = 'Picture could not be imported.'
      render 'new_import_to_album'
    end
  end


  def create_from_import_to_event
    @picture = PictureBuilder.create_from_import_and_join_nested_event(picture_params)
    if @picture.save
      flash[:notice] = 'Picture was successfully imported.'
      redirect_to edit_admin_picture_path(@picture.id_admin)
    else
      if @arlocal_settings.admin_forms_auto_keyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      @events = QueryEvents.new.order_by_start_time_asc
      flash[:notice] = 'Picture could not be imported.'
      render 'new_import_to_event'
    end
  end


  def create_from_upload
    @picture = PictureBuilder.create_from_upload(picture_params)
    if @picture.save
      flash[:notice] = 'Picture was successfully uploaded.'
      redirect_to edit_admin_picture_path(@picture.id_admin)
    else
      if @arlocal_settings.admin_forms_auto_keyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      flash[:notice] = 'Picture could not be uploaded.'
      render 'new_upload_single'
    end
  end


  def create_from_upload_to_album
    @picture = PictureBuilder.create_from_upload_and_join_nested_album(picture_params)
    if @picture.save
      flash[:notice] = 'Picture was successfully uploaded.'
      redirect_to edit_admin_picture_path(@picture.id_admin)
    else
      if @arlocal_settings.admin_forms_auto_keyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      @albums = QueryAlbums.new.order_by_title_asc
      flash[:notice] = 'Picture could not be uploaded.'
      render 'new_upload_to_album'
    end
  end


  def create_from_upload_to_event
    @picture = PictureBuilder.create_from_upload_and_join_nested_event(picture_params)
    if @picture.save
      flash[:notice] = 'Picture was successfully uploaded.'
      redirect_to edit_admin_picture_path(@picture.id_admin)
    else
      if @arlocal_settings.admin_forms_auto_keyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      @events = QueryEvents.new.order_by_start_time_asc
      flash[:notice] = 'Picture could not be uploaded.'
      render 'new_upload_to_event'
    end
  end


  def destroy
    @picture = Picture.friendly.find(params[:id])
    @picture.destroy
    flash[:notice] = 'Picture record was destroyed, file remains in filesystem.'
    redirect_to action: :index
  end


  def edit
    @picture = QueryPictures.find(params[:id])
    @picture_neighbors = QueryPictures.new(arlocal_settings: @arlocal_settings).action_admin_show_neighborhood(@picture)
    @form_metadata = FormPictureMetadata.new(pane: params[:pane])
  end


  def index
    determine_index_sorting
    @pictures = QueryPictures.new(arlocal_settings: @arlocal_settings, params: params).action_admin_index
  end


  def index_by_page
    determine_index_sorting
    page = QueryPictures.new(arlocal_settings: @arlocal_settings).action_admin_index_by_page(limit: params[:limit], page: params[:page])
    @pictures = page.collection
    @page_nav_data = page.nav_data
  end


  def new
    @picture = PictureBuilder.build_with_defaults
    @form_metadata = FormPictureMetadata.new
    if @arlocal_settings.admin_forms_auto_keyword_enabled
      @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      @picture.picture_keywords.build(keyword_id: @auto_keyword.keyword_id)
    end
  end


  def new_import_menu
  end


  def new_import_single
    @picture = PictureBuilder.build_with_defaults
    if @arlocal_settings.admin_forms_auto_keyword_enabled
      @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
    end
  end


  def new_import_to_album
    @picture = PictureBuilder.build_with_defaults
    @albums = QueryAlbums.new.order_by_title_asc
    if @arlocal_settings.admin_forms_auto_keyword_enabled
      @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
    end
  end


  def new_import_to_event
    @picture = PictureBuilder.build_with_defaults
    @events = QueryEvents.new.order_by_start_time_asc
    if @arlocal_settings.admin_forms_auto_keyword_enabled
      @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
    end
  end


  def new_upload_menu
  end


  def new_upload_single
    @picture = PictureBuilder.build_with_defaults
    if @arlocal_settings.admin_forms_auto_keyword_enabled
      @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
    end
  end


  def new_upload_to_album
    @picture = PictureBuilder.build_with_defaults
    @albums = QueryAlbums.new.order_by_title_asc
    if @arlocal_settings.admin_forms_auto_keyword_enabled
      @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
    end
  end


  def new_upload_to_event
    @picture = PictureBuilder.build_with_defaults
    @events = QueryEvents.new.order_by_start_time_asc
    if @arlocal_settings.admin_forms_auto_keyword_enabled
      @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
    end
  end


  def purge_image
    @picture = QueryPictures.find(params[:id])
    @picture.image.purge
    flash[:notice] = 'Attachment purged from picture.'
    redirect_to edit_admin_picture_path(@picture.id_admin, pane: params[:pane])
  end


  def show
    @picture = QueryPictures.find(params[:id])
    @picture_neighbors = QueryPictures.new(arlocal_settings: @arlocal_settings).action_admin_show_neighborhood(@picture)
  end


  def update
    @picture = QueryPictures.find(params[:id])
    if @picture.update_and_recount_joined_resources(picture_params)
      flash[:notice] = 'Picture was successfully updated.'
      redirect_to edit_admin_picture_path(@picture.id_admin, pane: params[:pane])
    else
      @picture_neighbors = QueryPictures.new(arlocal_settings: @arlocal_settings).action_admin_show_neighborhood(@picture)
      @form_metadata = FormPictureMetadata.new(pane: params[:pane])
      flash[:notice] = 'Picture could not be updated.'
      render 'edit'
    end
  end



  # def refresh_exif
  #   @picture = QueryPictures.find(params[:id])
  #   if PictureBuilder.new.refresh_exif(@picture)
  #     flash[:notice] = 'Picture EXIF was successfully refreshed.'
  #     redirect_to edit_admin_picture_path(@picture.id_admin, pane: 'datetime')
  #   else
  #     flash[:notice] = 'Picture EXIF could not be refreshed.'
  #     render 'edit'
  #   end
  # end
  #
  #
  # def index_by_keyword
  #   @keyword = Keyword.friendly.find(params[:keyword_id])
  #   @pictures = QueryPictures.new(arlocal_settings: @arlocal_settings).action_admin_index_by_keyword(@keyword, page: params[:page])
  #   render action: :index
  # end
  #
  #
  # def index_not_keyworded
  #   @pictures = QueryPictures.new(arlocal_settings: @arlocal_settings).action_admin_index_not_keyworded(page: params[:page])
  #   render action: :index
  # end



  private


  def determine_index_sorting
    if params[:filter] == nil
      params[:filter] = SorterIndexAdminPictures.find(@arlocal_settings.admin_index_pictures_sorter_id).symbol
    end
  end


  def picture_params
    params.require(:picture).permit(
      :credits_parser_id,
      :credits_text_markup,
      :datetime_from_manual_entry_year,
      :datetime_from_manual_entry_month,
      :datetime_from_manual_entry_day,
      :datetime_from_manual_entry_hour,
      :datetime_from_manual_entry_minute,
      :datetime_from_manual_entry_second,
      :description_parser_id,
      :description_text_markup,
      :image,
      :indexed,
      :published,
      :show_can_display_title,
      :title_parser_id,
      :title_text_markup,
      :source_catalog_file_path,
      :source_type,
      album_pictures_attributes: [
        :id,
        :album_id,
        :_destroy
      ],
      event_pictures_attributes: [
        :id,
        :event_id,
        :_destroy
      ],
      picture_keywords_attributes: [
        :id,
        :keyword_id,
        :_destroy
      ]
    )
  end


end
