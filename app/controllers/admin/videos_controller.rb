class Admin::VideosController < AdminController


  def create
    @video = VideoBuilder.build do |b|
      b.assign_default_attributes
      b.assign_given_attributes(video_params)
    end
    if @video.save
      flash[:notice] = 'Video was successfully created.'
      redirect_to edit_admin_video_path(@video.id_admin)
    else
      @form_metadata = FormVideoMetadata.new(pane: params[:pane], settings: @arlocal_settings)
      if @arlocal_settings.admin_forms_auto_keyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      flash[:notice] = 'Video could not be created.'
      render 'new'
    end
  end


  def destroy
    @video = QueryVideos.new.find(params[:id])
    @video.destroy
    flash[:notice] = 'Video was destroyed.'
    redirect_to action: :index
  end


  def edit
    @video = QueryVideos.new(arlocal_settings: @arlocal_settings, params: params).action_admin_edit
    @form_metadata = FormVideoMetadata.new(pane: params[:pane], settings: @arlocal_settings)
  end


  def index
    @videos = QueryVideos.new(arlocal_settings: @arlocal_settings, params: params).action_admin_index
  end


  def new
    @video = VideoBuilder.build { |b| b.assign_default_attributes }
    @form_metadata = FormVideoMetadata.new(pane: params[:pane], settings: @arlocal_settings)
    if @arlocal_settings.admin_forms_auto_keyword_enabled
      @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      @video.video_keywords.build(keyword_id: @auto_keyword.keyword_id)
    end
  end


  def show
    @video = QueryVideos.new(arlocal_settings: @arlocal_settings, params: params).action_admin_show
  end


  def update
    @video = VideoBuilder.build do |b|
      b.find_preexisting(params[:id])
      b.assign_given_attributes(video_params)
      b.read_source_dimensions
    end
    # TODO:
    # if @video.update_and_recount_joined_resources(video_params)
    if @video.update(video_params)
      flash[:notice] = 'Video was successfully updated.'
      redirect_to edit_admin_video_path(@video.id_admin, pane: params[:pane])
    else
      @form_metadata = FormVideoMetadata.new(pane: params[:pane], settings: @arlocal_settings)
      flash[:notice] = 'Video could not be updated.'
      render 'edit'
    end
  end



  private


  def video_params
    params.require(:video).permit(
      :copyright_parser_id,
      :copyright_text_markup,
      :date_released,
      :description_parser_id,
      :description_text_markup,
      :indexed,
      :involved_people_parser_id,
      :involved_people_text_markup,
      :published,
      :slug,
      :source_catalog_file_path,
      :source_dimension_height,
      :source_dimension_width,
      :source_type,
      :source_url,
      :title,
      video_keywords_attributes: [
        :id,
        :keyword_id,
        :_destroy
      ]
    )
  end


end
