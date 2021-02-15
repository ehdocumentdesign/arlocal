class Admin::AlbumsController < AdminController


  def audio_create_from_import
    @album = Album.find(params[:id])
    @audio = AudioBuilder.create_from_import_nested_within_album(@album, album_params, arlocal_settings: @arlocal_settings)
    if @audio.save
      flash[:notice] = 'Audio was successfully imported.'
      redirect_to edit_admin_album_path(@album.id_admin, pane: :audio)
    else
      @form_metadata = FormAlbumMetadata.new(pane: :audio_import, settings: @arlocal_settings)
      flash[:notice] = 'Audio could not be imported.'
      render 'edit'
    end
  end


  def audio_create_from_upload
    @album = Album.find(params[:id])
    @audio = AudioBuilder.create_from_upload_nested_within_album(@album, album_params, arlocal_settings: @arlocal_settings)
    if @audio.save
      flash[:notice] = 'Audio was successfully uploaded.'
      redirect_to edit_admin_album_path(@album.id_admin, pane: :audio)
    else
      if @arlocal_settings.admin_forms_auto_keyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      @form_metadata = FormAlbumMetadata.new(pane: :audio_import, settings: @arlocal_settings)
      flash[:notice] = 'Audio could not be uploaded.'
      render 'edit'
    end
  end


  def audio_join_by_keyword
    @keyword = QueryKeywords.new.find(params[:album][:keywords])
    @album = QueryAlbums.new.find(params[:id])
    @album.audio << QueryAudio.new.find_by_keyword(@keyword)
    flash[:notice] = 'Album was successfully updated.'
    redirect_to edit_admin_album_path(@album, pane: params[:pane])
  end


  def create
    @album = AlbumBuilder.new.default_with(album_params)
    if @album.save
      flash[:notice] = 'Album was successfully created.'
      redirect_to edit_admin_album_path(@album.id_admin)
    else
      @form_metadata = FormAlbumMetadata.new(pane: params[:pane], settings: @arlocal_settings)
      if @arlocal_settings.admin_forms_auto_keyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      flash[:notice] = 'Album could not be created.'
      render 'new'
    end
  end


  def destroy
    @album = QueryAlbums.new.find(params[:id])
    @album.destroy
    flash[:notice] = 'Album was destroyed.'
    redirect_to action: :index
  end


  def edit
    @album = QueryAlbums.new(arlocal_settings: @arlocal_settings, params: params).action_admin_edit
    @album_neighbors = QueryAlbums.new(arlocal_settings: @arlocal_settings).action_admin_show_neighborhood(@album)
    @form_metadata = FormAlbumMetadata.new(pane: params[:pane], settings: @arlocal_settings)
  end


  def index
    if params[:filter] == nil
      params[:filter] = SorterIndexAdminAlbums.find(@arlocal_settings.admin_index_albums_sorter_id).symbol
    end
    @albums = QueryAlbums.new(arlocal_settings: @arlocal_settings, params: params).action_admin_index
  end


  def new
    @album = AlbumBuilder.new.default
    @form_metadata = FormAlbumMetadata.new(pane: params[:pane], settings: @arlocal_settings)
    if @arlocal_settings.admin_forms_auto_keyword_enabled
      @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      @album.album_keywords.build(keyword_id: @auto_keyword.keyword_id)
    end
  end


  def picture_create_from_import
    @album = Album.find(params[:id])
    @picture = PictureBuilder.create_from_import_nested_within_album(@album, album_params)
    if @picture.save
      flash[:notice] = 'Picture was successfully imported.'
      redirect_to edit_admin_album_path(@album.id_admin, pane: :pictures)
    else
      @form_metadata = FormAlbumMetadata.new(pane: :picture_import, settings: @arlocal_settings)
      flash[:notice] = 'Picture could not be imported.'
      render 'edit'
    end
  end


  def picture_create_from_upload
    @album = Album.find(params[:id])
    @picture = PictureBuilder.create_from_upload_nested_within_album(@album, album_params)
    if @picture.save
      flash[:notice] = 'Picture was successfully uploaded.'
      redirect_to edit_admin_album_path(@album.id_admin, pane: :pictures)
    else
      if @arlocal_settings.admin_forms_auto_keyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      @form_metadata = FormAlbumMetadata.new(pane: :picture_import, settings: @arlocal_settings)
      flash[:notice] = 'Picture could not be uploaded.'
      render 'edit'
    end
  end


  def pictures_join_by_keyword
    @keyword = QueryKeywords.new.find(params[:album][:keywords])
    @album = QueryAlbums.new.find(params[:id])
    @album.pictures << QueryPictures.new.find_by_keyword(@keyword)
    flash[:notice] = 'Album was successfully updated.'
    redirect_to edit_admin_album_path(@album, pane: params[:pane])
  end


  def show
    @album = QueryAlbums.new(arlocal_settings: @arlocal_settings, params: params).action_admin_show
    @album_neighbors = QueryAlbums.new(arlocal_settings: @arlocal_settings).action_admin_show_neighborhood(@album)
  end


  def update
    @album = QueryAlbums.new.find(params[:id])
    if @album.update_and_recount_joined_resources(album_params)
      flash[:notice] = 'Album was successfully updated.'
      redirect_to edit_admin_album_path(@album.id_admin, pane: params[:pane])
    else
      @form_metadata = FormAlbumMetadata.new(pane: params[:pane], settings: @arlocal_settings)
      flash[:notice] = 'Album could not be updated.'
      render 'edit'
    end
  end



  private


  def album_params
    params.require(:album).permit(
      :album_artist,
      :album_pictures_sorter_id,
      :artist,
      :copyright_parser_id,
      :copyright_text_markup,
      :credits_parser_id,
      :date_released,
      :description_parser_id,
      :description_text_markup,
      :index_can_display_tracklist,
      :index_tracklist_audio_includes_subtitles,
      :indexed,
      :involved_people_parser_id,
      :involved_people_text_markup,
      :musicians_parser_id,
      :musicians_text_markup,
      :published,
      :show_can_cycle_pictures,
      :show_can_have_more_pictures_link,
      :show_can_have_vendor_widget_gumroad,
      :title,
      :slug,
      :vendor_widget_gumroad,
      album_audio_attributes: [
        :album_order,
        :audio_id,
        :id,
        :_destroy
      ],
      album_pictures_attributes: [
        :album_order,
        :id,
        :is_coverpicture,
        :picture_id,
        :_destroy
      ],
      album_keywords_attributes: [
        :id,
        :keyword_id,
        :_destroy
      ],
      audio_attributes: [
        :recording,
        :source_catalog_file_path
      ],
      pictures_attributes: [
        :image,
        :source_catalog_file_path
      ]
    )
  end


end
