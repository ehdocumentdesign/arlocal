class Admin::VideosController < AdminController


  def create
    @video = VideoBuilder.create(video_params)
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
    @video = QueryVideos.find(params[:id])
    @video.destroy
    flash[:notice] = 'Video was destroyed.'
    redirect_to action: :index
  end


  def edit
    @video = QueryVideos.find(params[:id])
    @video_neighbors = QueryVideos.new(arlocal_settings: @arlocal_settings).action_admin_show_neighborhood(@video)
    @form_metadata = FormVideoMetadata.new(pane: params[:pane], settings: @arlocal_settings)
  end


  def index
    if params[:filter] == nil
      params[:filter] = SorterIndexAdminVideos.find(@arlocal_settings.admin_index_videos_sorter_id).symbol
    end
    @videos = QueryVideos.new(arlocal_settings: @arlocal_settings, params: params).action_admin_index
  end


  def new
    @video = VideoBuilder.build_with_defaults
    @form_metadata = FormVideoMetadata.new(pane: params[:pane], settings: @arlocal_settings)
    if @arlocal_settings.admin_forms_auto_keyword_enabled
      @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      @video.video_keywords.build(keyword_id: @auto_keyword.keyword_id)
    end
  end


  def show
    @video = QueryVideos.find(params[:id])
    @video_neighbors = QueryVideos.new(arlocal_settings: @arlocal_settings).action_admin_show_neighborhood(@video)
  end


  def update
    @video = QueryVideos.find(params[:id])
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
      ],
      video_picture_attributes: [
        :id,
        :picture_id,
        :_destroy
      ]
    )
  end


end
