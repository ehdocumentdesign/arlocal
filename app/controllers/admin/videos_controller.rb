class Admin::VideosController < AdminController


  def create
  end


  def destroy
  end


  def edit
    @video = QueryVideos.new(arlocal_settings: @arlocal_settings, params: params).action_admin_edit
    @form_metadata = FormVideoMetadata.new(pane: params[:pane], settings: @arlocal_settings)
  end


  def index
    @videos = QueryVideos.new(arlocal_settings: @arlocal_settings, params: params).action_admin_index
  end


  def new
    @video = VideoBuilder.new.default
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
      :video_keywords_attributes: [
        :id,
        :keyword_id,
        :_destroy
      ]
    )
  end

  
end
