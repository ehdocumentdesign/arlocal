class Admin::VideosController < AdminController


  before_action :verify_nested_picture_file_exists, only: [ :picture_create_from_import ]


  def create
    @video = VideoBuilder.create(params_video_permitted)
    if @video.save
      flash[:notice] = 'Video was successfully created.'
      redirect_to edit_admin_video_path(@video.id_admin)
    else
      @form_metadata = FormVideoMetadata.new(pane: params[:pane], arlocal_settings: @arlocal_settings)
      if @arlocal_settings.admin_forms_auto_keyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      flash[:notice] = 'Video could not be created.'
      render 'new'
    end
  end


  def destroy
    @video = QueryVideos.find_admin(params[:id])
    @video.destroy
    flash[:notice] = 'Video was destroyed.'
    redirect_to action: :index
  end


  def edit
    @video = QueryVideos.find_admin(params[:id])
    @video_neighbors = QueryVideos.neighborhood_admin(@video, @arlocal_settings)
    @form_metadata = FormVideoMetadata.new(pane: params[:pane], arlocal_settings: @arlocal_settings)
  end


  def index
    @videos = QueryVideos.index_admin(@arlocal_settings, params)
  end


  def new
    @video = VideoBuilder.build_with_defaults
    @form_metadata = FormVideoMetadata.new(pane: params[:pane], arlocal_settings: @arlocal_settings)
    if @arlocal_settings.admin_forms_auto_keyword_enabled
      @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      @video.video_keywords.build(keyword_id: @auto_keyword.keyword_id)
    end
  end


  def picture_create_from_import
    @video = QueryVideos.find_admin(params[:id])
    @picture = PictureBuilder.create_from_import_nested_within_video(@video, params_video_permitted)
    if @picture.save
      flash[:notice] = 'Picture was successfully imported.'
      redirect_to edit_admin_video_path(@video.id_admin, pane: :picture)
    else
      @form_metadata = FormVideoMetadata.new(pane: :picture_import, arlocal_settings: @arlocal_settings)
      flash[:notice] = 'Picture could not be imported.'
      render 'edit'
    end
  end


  def picture_create_from_upload
    @video = QueryVideo.find_admin(params[:id])
    @picture = PictureBuilder.create_from_upload_nested_within_video(@video, params_video_permitted)
    if @picture.save
      flash[:notice] = 'Picture was successfully uploaded.'
      redirect_to edit_admin_video_path(@video.id_admin, pane: :picture)
    else
      if @arlocal_settings.admin_forms_auto_keyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      @form_metadata = FormAlbumMetadata.new(pane: :picture_import, arlocal_settings: @arlocal_settings)
      flash[:notice] = 'Picture could not be uploaded.'
      render 'edit'
    end
  end


  def show
    @video = QueryVideos.find_admin(params[:id])
    @video_neighbors = QueryVideos.neighborhood_admin(@video, @arlocal_settings)
  end


  def update
    @video = QueryVideos.find_admin(params[:id])
    if @video.update(params_video_permitted)
      flash[:notice] = 'Video was successfully updated.'
      redirect_to edit_admin_video_path(@video.id_admin, pane: params[:pane])
    else
      @form_metadata = FormVideoMetadata.new(pane: params[:pane], arlocal_settings: @arlocal_settings)
      flash[:notice] = 'Video could not be updated.'
      render 'edit'
    end
  end



  private


  def params_video_permitted
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
      :source_embed,
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


  def verify_file(filename)
    if File.exists?(filename) == false
      flash[:notice] = "File not found: #{filename}"
      redirect_to request.referrer
    end
  end


  def verify_nested_picture_file_exists
    filename = helpers.catalog_file_path(params_video_permitted['pictures_attributes']['0']['source_catalog_file_path'])
    verify_file(filename)
  end


end
