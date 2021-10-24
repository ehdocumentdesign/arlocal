class Admin::EventsController < AdminController


  before_action :verify_nested_audio_file_exists,   only: [ :audio_create_from_import ]
  before_action :verify_nested_picture_file_exists, only: [ :picture_create_from_import ]


  def add_pictures_by_keyword
    @keyword = QueryKeywords.find(params[:event][:keywords])
    @event = QueryEvents.find_admin(params[:id])
    @event.pictures << QueryPictures.find_with_keyword(@keyword)
    redirect_to edit_admin_event_path(@event, pane: params[:pane])
  end


  def audio_create_from_import
    @event = QueryEvents.find_admin(params[:id])
    @audio = AudioBuilder.create_from_import_nested_within_event(@event, params_event_permitted, arlocal_settings: @arlocal_settings)
    if @audio.save
      flash[:notice] = 'Audio was successfully imported.'
      redirect_to edit_admin_event_path(@event.id_admin, pane: :audio)
    else
      @form_metadata = FormEventMetadata.new(pane: :audio_import, arlocal_settings: @arlocal_settings)
      flash[:notice] = 'Audio could not be imported.'
      render 'edit'
    end
  end


  def audio_create_from_upload
    @event = QueryEvents.find_admin(params[:id])
    @audio = AudioBuilder.create_from_upload_nested_within_event(@event, params_event_permitted, arlocal_settings: @arlocal_settings)
    if @audio.save
      flash[:notice] = 'Audio was successfully uploaded.'
      redirect_to edit_admin_event_path(@event.id_admin, pane: :audio)
    else
      if @arlocal_settings.admin_forms_auto_keyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      @form_metadata = FormEventMetadata.new(pane: :audio_import, arlocal_settings: @arlocal_settings)
      flash[:notice] = 'Audio could not be uploaded.'
      render 'edit'
    end
  end


  def create
    @event = EventBuilder.create(params_event_permitted)
    if @event.save
      flash[:notice] = 'Event was successfully created.'
      redirect_to edit_admin_event_path(@event.id_admin)
    else
      @form_metadata = FormEventMetadata.new
      if @arlocal_settings.admin_forms_auto_keyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      flash[:notice] = 'Event could not be created.'
      render 'new'
    end
  end


  def destroy
    @event = QueryEvents.find_admin(params[:id])
    @event.destroy
    flash[:notice] = 'Event was destroyed.'
    redirect_to action: :index
  end


  def edit
    @event = QueryEvents.find_admin(params[:id])
    @event_neighbors = QueryEvents.neighborhood_admin(@event, @arlocal_settings)
    @form_metadata = FormEventMetadata.new(pane: params[:pane], arlocal_settings: @arlocal_settings)
  end


  def index
    @events_calendar = Calendar.by_year(QueryEvents.index_admin(@arlocal_settings, params))
    render :index_hash
  end


  def new
    @event = EventBuilder.build_default
    @form_metadata = FormEventMetadata.new
    if @arlocal_settings.admin_forms_auto_keyword_enabled
      @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      @event.event_keywords.build(keyword_id: @auto_keyword.keyword_id)
    end
  end


  def picture_create_from_import
    @event = QueryEvents.find_admin(params[:id])
    @picture = PictureBuilder.create_from_import_nested_within_event(@event, params_event_permitted)
    if @picture.save
      flash[:notice] = 'Picture was successfully imported.'
      redirect_to edit_admin_event_path(@event.id_admin, pane: :pictures)
    else
      @form_metadata = FormEventMetadata.new(pane: :picture_import, arlocal_settings: @arlocal_settings)
      flash[:notice] = 'Picture could not be imported.'
      render 'edit'
    end
  end


  def picture_create_from_upload
    @event = QueryEvents.find_admin(params[:id])
    @picture = PictureBuilder.create_from_upload_nested_within_event(@event, params_event_permitted)
    if @picture.save
      flash[:notice] = 'Picture was successfully uploaded.'
      redirect_to edit_admin_event_path(@event.id_admin, pane: :pictures)
    else
      if @arlocal_settings.admin_forms_auto_keyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      @form_metadata = FormEventMetadata.new(pane: :picture_import, arlocal_settings: @arlocal_settings)
      flash[:notice] = 'Picture could not be uploaded.'
      render 'edit'
    end
  end


  def show
    @event = QueryEvents.find_admin(params[:id])
    @event_neighbors = QueryEvents.neighborhood_admin(@event, @arlocal_settings)
  end


  def update
    @event = QueryEvents.find_admin(params[:id])
    if @event.update_and_recount_joined_resources(params_event_permitted)
      flash[:notice] = 'Event was successfully updated.'
      redirect_to edit_admin_event_path(@event.id_admin, pane: params[:pane])
    else
      @form_metadata = FormEventMetadata.new(pane: params[:pane], arlocal_settings: @arlocal_settings)
      flash[:notice] = 'Event could not be updated.'
      render 'edit'
    end
  end



  private


  def params_event_permitted
    params.require(:event).permit(
      :alert,
      :city,
      :datetime_year,
      :datetime_month,
      :datetime_day,
      :datetime_hour,
      :datetime_min,
      :datetime_zone,
      :details_parser_id,
      :details_text_markup,
      :event_pictures_sorter_id,
      :indexed,
      :map_url,
      :published,
      :show_can_cycle_pictures,
      :show_can_have_more_pictures_link,
      :title_parser_id,
      :title_text_markup,
      :venue,
      :venue_url,
      audio_attributes: [
        :source_attachment,
        :source_catalog_file_path
      ],
      event_audio_attributes: [
        :audio_id,
        :event_order,
        :id,
        :_destroy
      ],
      event_keywords_attributes: [
        :id,
        :keyword_id,
        :_destroy
      ],
      event_pictures_attributes: [
        :event_id,
        :event_order,
        :id,
        :is_coverpicture,
        :picture_id,
        :_destroy
      ],
      pictures_attributes: [
        :source_attachment,
        :source_catalog_file_path
      ]
    )
  end


  def verify_file(filename)
    if File.exists?(filename) == false
      flash[:notice] = "File not found: #{filename}"
      redirect_to request.referrer
    end
  end


  def verify_nested_audio_file_exists
    filename = helpers.catalog_file_path(params_event_permitted['audio_attributes']['0']['source_catalog_file_path'])
    verify_file(filename)
  end


  def verify_nested_picture_file_exists
    filename = helpers.catalog_file_path(params_event_permitted['pictures_attributes']['0']['source_catalog_file_path'])
    verify_file(filename)
  end



end
