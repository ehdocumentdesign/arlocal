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

end
