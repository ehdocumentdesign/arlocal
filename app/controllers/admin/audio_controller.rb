class Admin::AudioController < AdminController


  def attachment_add
    @audio = QueryAudio.new.find(params[:id])
    @audio.recording.attach(audio_params[:recording])
    if @audio.save
      flash[:notice] = 'Attachment added to audio.'
      redirect_to edit_admin_audio_path(@audio.id, pane: params[:pane])
    else
      @form_metadata = FormAudioMetadata.new(pane: params[:pane])
      flash[:notice] = 'Attachment could not be added to audio.'
      render 'edit'
    end
  end


  def attachment_purge
    @audio = QueryAudio.new.find(params[:id])
    @audio.recording.purge
    flash[:notice] = 'Attachment purged from audio.'
    redirect_to edit_admin_audio_path(@audio.id, pane: params[:pane])
  end


  def create
    @audio = AudioBuilder.new.default_with(audio_params)
    if @audio.save
      flash[:notice] = 'Audio was successfully created.'
      redirect_to edit_admin_audio_path(@audio.id)
    else
      @form_metadata = FormAudioMetadata.new
      if @arlocal_settings.admin_forms_auto_keyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      flash[:notice] = 'Audio could not be created.'
      render 'new'
    end
  end


  def create_from_import
    @audio = AudioBuilder.new.prepare_from_import(audio_params)
    if @audio.save
      flash[:notice] = 'Audio was successfully imported.'
      redirect_to edit_admin_audio_path(@audio.id)
    else
      @form_metadata = FormAudioMetadata.new
      if @arlocal_settings.admin_forms_auto_keyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      flash[:notice] = 'Audio could not be imported.'
      render 'new'
    end
  end


  def create_from_import_to_album
    @audio = AudioBuilder.new.prepare_from_import_for_album(audio_params)
    if @audio.save
      flash[:notice] = 'Audio was successfully imported.'
      redirect_to edit_admin_audio_path(@audio.id)
    else
      if @arlocal_settings.admin_forms_auto_keyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      @albums = AlbumQuery.new.order_by_title_asc
      flash[:notice] = 'Audio could not be imported.'
      render 'audio#new_import_to_album'
    end
  end


  def create_from_import_to_event
    @audio = AudioBuilder.new.prepare_from_import_for_event(audio_params)
    if @audio.save
      flash[:notice] = 'Audio was successfully imported.'
      redirect_to edit_admin_audio_path(@audio.id)
    else
      if @arlocal_settings.admin_forms_auto_keyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      @events = EventQuery.new.order_by_title_asc
      flash[:notice] = 'Audio could not be imported.'
      render 'audio#new_import_to_album'
    end
  end


  def create_from_upload
    @audio = AudioBuilder.new.prepare_from_upload(audio_params)
    if @audio.save
      flash[:notice] = 'Audio was successfully uploaded.'
      redirect_to edit_admin_audio_path(@audio.id)
    else
      if @arlocal_settings.admin_forms_auto_keyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      flash[:notice] = 'Audio could not be uploaded.'
      render 'audio#new_upload_single'
    end
  end


  def create_from_upload_to_album
    @audio = AudioBuilder.new.prepare_from_upload_for_album(audio_params)
    if @audio.save
      flash[:notice] = 'Audio was successfully uploaded.'
      redirect_to edit_admin_audio_path(@audio.id)
    else
      if @arlocal_settings.admin_forms_auto_keyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      @events = EventQuery.new.order_by_title_asc
      flash[:notice] = 'Audio could not be uploaded.'
      render 'audio#new_upload_to_album'
    end
  end


  def create_from_upload_to_event
    @audio = AudioBuilder.new.prepare_from_upload_for_event(audio_params)
    if @audio.save
      flash[:notice] = 'Audio was successfully uploaded.'
      redirect_to edit_admin_audio_path(@audio.id)
    else
      if @arlocal_settings.admin_forms_auto_keyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      @events = EventQuery.new.order_by_start_time_asc
      flash[:notice] = 'Audio could not be uploaded.'
      render 'audio#new_upload_to_event'
    end
  end


  def destroy
    @audio = QueryAudio.new.find(params[:id])
    @audio.recording.purge
    @audio.destroy
    flash[:notice] = 'Audio was destroyed.'
    redirect_to action: :index
  end


  def edit
    @audio = QueryAudio.new.find(params[:id])
    @audio_neighbors = QueryAudio.new(arlocal_settings: @arlocal_settings).action_admin_show_neighborhood(@audio)
    @form_metadata = FormAudioMetadata.new(pane: params[:pane])
  end


  def index
    if params[:filter] == nil
      params[:filter] = SorterIndexAdminAudio.find(@arlocal_settings.admin_index_audio_sorter_id).symbol
    end
    @audio = QueryAudio.new.action_admin_index(params[:filter])
  end


  def index_by_album
    @album = QueryAlbums.new.find_by_slug(params[:album_id])
    @audio = QueryAudio.new.admin_index_by_album(@album)
    render action: :index
  end


  def index_by_keyword
    @keyword = Keyword.find_by_slug!(params[:keyword_id])
    @audio = QueryAudio.new.admin_index_by_keyword(@keyword)
    render action: :index
  end


  def index_without_albums
    @audio = QueryAudio.new.index_no_albums
    render action: :index
  end


  def index_without_keywords
    @audio = QueryAudio.new.index_no_keywords
    render action: :index
  end


  def new
    @audio = AudioBuilder.new(@arlocal_settings).default
    @form_metadata = FormAudioMetadata.new
    if @arlocal_settings.admin_forms_auto_keyword_enabled
      @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      @audio.audio_keywords.build(keyword_id: @auto_keyword.keyword_id)
    end
  end


  def new_import_menu
  end


  def new_import_single
    @audio = AudioBuilder.new.default
    if @arlocal_settings.admin_forms_auto_keyword_enabled
      @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
    end
  end


  def new_import_to_album
    @audio = AudioBuilder.new.default
    @albums = QueryAlbums.new.order_by_title_asc
    if @arlocal_settings.admin_forms_auto_keyword_enabled
      @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
    end
  end


  def new_import_to_event
    @audio = AudioBuilder.new.default
    @events = QueryEvents.new.order_by_start_time_asc
    if @arlocal_settings.admin_forms_auto_keyword_enabled
      @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
    end
  end


  def new_upload_menu
  end


  def new_upload_single
    @audio = AudioBuilder.new.default
    if @arlocal_settings.admin_forms_auto_keyword_enabled
      @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
    end
  end


  def new_upload_to_album
    @audio = AudioBuilder.new.default
    @albums = QueryAlbums.new.order_by_title_asc
    if @arlocal_settings.admin_forms_auto_keyword_enabled
      @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
    end
  end


  def new_upload_to_event
    @audio = AudioBuilder.new.default
    @events = QueryEvents.new.order_by_start_time_asc
    if @arlocal_settings.admin_forms_auto_keyword_enabled
      @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
    end
  end


  def refresh_id3
    @audio = QueryAudio.new.find(params[:id])
    if AudioBuilder.new.refresh_id3(@audio)
      flash[:notice] = "Audio ID3 was successfully refreshed."
      redirect_to edit_admin_audio_path(@audio.id_admin, pane: 'id3')
    else
      flash[:notice] = "Audio ID3 could not be refreshed."
      @audio_neighbors = QueryAudio.new(arlocal_settings: @arlocal_settings).action_admin_show_neighborhood(@audio)
      @form_metadata = FormAudioMetadata.new(pane: params[:pane])
      render 'edit'
    end
  end


  def show
    @audio = QueryAudio.new.find(params[:id])
    @audio_neighbors = QueryAudio.new(arlocal_settings: @arlocal_settings).action_admin_show_neighborhood(@audio)
  end


  def update
    @audio = QueryAudio.new.find(params[:id])
    if @audio.update_and_recount_joined_resources(audio_params)
      flash[:notice] = 'Audio was successfully updated.'
      redirect_to edit_admin_audio_path(@audio.id_admin, pane: params[:pane])
    else
      @audio_neighbors = QueryAudio.new(arlocal_settings: @arlocal_settings).action_admin_show_neighborhood(@audio)
      @form_metadata = FormAudioMetadata.new(pane: params[:pane])
      flash[:notice] = 'Audio could not be updated.'
      render 'edit'
    end
  end



  private


  def audio_params
    params.require(:audio).permit(
      :artist,
      :audio_artist,
      :catalog_file_path,
      :composer,
      :copyright_parser_id,
      :copyright_text_markup,
      :date_released,
      :description_parser_id,
      :description_text_markup,
      :duration_hrs,
      :duration_mins,
      :duration_secs,
# TODO: check this attribute
      :duration_mils,
      :indexed,
      :involved_people_parser_id,
      :involved_people_text_markup,
      :isrc_country_code,
      :isrc_designation_code,
      :isrc_registrant_code,
      :isrc_year_of_reference,
      :musicians_parser_id,
      :musicians_text_markup,
      :published,
      :recording,
      :subtitle,
      :title,
      album_audio_attributes: [
        :id,
        :album_id,
        :album_order,
        :_destroy
      ],
      audio_keywords_attributes: [
        :id,
        :keyword_id,
        :_destroy
      ],
      event_audio_attributes: [
        :id,
        :event_id,
        :event_order,
        :_destroy
      ]
    )
  end


end
