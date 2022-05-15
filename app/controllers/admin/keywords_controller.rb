class Admin::KeywordsController < AdminController


  def audio_create_from_import
    @keyword = QueryKeywords.find_admin(params[:id])
    @audio = AudioBuilder.create_from_import_nested_within_keyword(@keyword, params_keyword_permitted, arlocal_settings: @arlocal_settings)
    if @audio.save
      flash[:notice] = 'Audio was successfully imported.'
      redirect_to edit_admin_keyword_path(@keyword.id_admin, pane: :audio)
    else
      @form_metadata = FormKeywordMetadata.new(pane: :audio_import, arlocal_settings: @arlocal_settings)
      flash[:notice] = 'Audio could not be imported.'
      render 'edit'
    end
  end


  def audio_create_from_upload
    @keyword = QueryKeywords.find_admin(params[:id])
    @audio = AudioBuilder.create_from_upload_nested_within_keyword(@keyword, params_keyword_permitted, arlocal_settings: @arlocal_settings)
    if @audio.save
      flash[:notice] = 'Audio was successfully uploaded.'
      redirect_to edit_admin_keyword_path(@keyword.id_admin, pane: :audio)
    else
      if @arlocal_settings.admin_forms_auto_keyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      @form_metadata = FormKeywordMetadata.new(pane: :audio_import, arlocal_settings: @arlocal_settings)
      flash[:notice] = 'Audio could not be uploaded.'
      render 'edit'
    end
  end


  def create
    @keyword = KeywordBuilder.default_with(params_keyword_permitted)
    if @keyword.save
      flash[:notice] = 'Keyword was successfully created.'
      redirect_to edit_admin_keyword_path(@keyword.id_admin)
    else
      @form_metadata = FormKeywordMetadata.new
      flash[:notice] = 'Keyword could not be created.'
      render 'new'
    end
  end


  def destroy
    @keyword = QueryKeywords.find_admin(params[:id])
    @keyword.destroy
    flash[:notice] = 'Keyword was destroyed.'
    redirect_to action: :index
  end


  def edit
    @keyword = QueryKeywords.find_admin(params[:id])
    @keyword_neighbors = QueryKeywords.neighborhood_admin(@keyword)
    @form_metadata = FormKeywordMetadata.new(pane: params[:pane], arlocal_settings: @arlocal_settings)
  end


  def index
    @keywords = QueryKeywords.index_admin
  end


  def new
    @keyword = KeywordBuilder.default
    @form_metadata = FormKeywordMetadata.new
  end


  def picture_create_from_import
    @keyword = QueryKeywords.find_admin(params[:id])
    @picture = PictureBuilder.create_from_import_nested_within_keyword(@keyword, params_keyword_permitted)
    if @picture.save
      flash[:notice] = 'Picture was successfully imported.'
      redirect_to edit_admin_keyword_path(@keyword.id_admin, pane: :pictures)
    else
      @form_metadata = FormKeywordMetadata.new(pane: :picture_import, arlocal_settings: @arlocal_settings)
      flash[:notice] = 'Picture could not be imported.'
      render 'edit'
    end
  end


  def picture_create_from_upload
    @keyword = QueryKeywords.find_admin(params[:id])
    @picture = PictureBuilder.create_from_upload_nested_within_keyword(@keyword, params_keyword_permitted)
    if @picture.save
      flash[:notice] = 'Picture was successfully uploaded.'
      redirect_to edit_admin_keyword_path(@keyword.id_admin, pane: :pictures)
    else
      if @arlocal_settings.admin_forms_auto_keyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      @form_metadata = FormKeywordMetadata.new(pane: :picture_import, arlocal_settings: @arlocal_settings)
      flash[:notice] = 'Picture could not be uploaded.'
      render 'edit'
    end
  end




  def show
    @keyword = QueryKeywords.find_admin(params[:id])
    @keyword_neighbors = QueryKeywords.neighborhood_admin(@keyword)
  end


  def update
    @keyword = QueryKeywords.find_admin(params[:id])
    if @keyword.update_and_recount_joined_resources(params_keyword_permitted)
      flash[:notice] = 'Keyword was successfully updated.'
      redirect_to edit_admin_keyword_path(@keyword.id_admin, pane: params[:pane])
    else
      @form_metadata = FormKeywordMetadata.new(pane: params[:pane], arlocal_settings: @arlocal_settings)
      flash[:notice] = 'Keyword could not be updated.'
      render 'edit'
    end
  end



  private


  def params_keyword_permitted
    params.require(:keyword).permit(
      :can_select_albums,
      :can_select_events,
      :can_select_pictures,
      :can_select_videos,
      :order_selecting_albums,
      :order_selecting_events,
      :order_selecting_pictures,
      :order_selecting_videos,
      :title,
      :slug,
      album_keywords_attributes: [
        :id,
        :album_id,
        :_destroy
      ],
      audio_keywords_attributes: [
        :id,
        :audio_id,
        :_destroy
      ],
      event_keywords_attributes: [
        :id,
        :event_id,
        :_destroy
      ],
      picture_keywords_attributes: [
        :id,
        :picture_id,
        :_destroy
      ],
      video_keywords_attributes: [
        :id,
        :video_id,
        :_destroy
      ]
    )
  end


end



# def unkeyword_albums
#   @keyword = QueryKeywords.new.find(params[:id])
#   AlbumKeyword.where({keyword_id: @keyword.id}).each { |ak| ak.destroy }
#   flash[:notice] = 'Albums were unkeyworded.'
#   redirect_to edit_admin_keyword_path(@keyword, pane: params[:pane])
# end
#
#
# def unkeyword_audio
#   @keyword = QueryKeywords.new.find(params[:id])
#   AudioKeyword.where({keyword_id: @keyword.id}).each { |ak| ak.destroy }
#   flash[:notice] = 'Audio was unkeyworded.'
#   redirect_to edit_admin_keyword_path(@keyword, pane: params[:pane])
# end
#
#
# def unkeyword_events
#   @keyword = QueryKeywords.new.find(params[:id])
#   EventKeyword.where({keyword_id: @keyword.id}).each { |ek| ek.destroy }
#   flash[:notice] = 'Events were unkeyworded.'
#   redirect_to edit_admin_keyword_path(@keyword, pane: params[:pane])
# end
#
#
# def unkeyword_pictures
#   @keyword = QueryKeywords.new.find(params[:id])
#   PictureKeyword.where({keyword_id: @keyword.id}).each { |pk| pk.destroy }
#   flash[:notice] = 'Pictures were unkeyworded.'
#   redirect_to edit_admin_keyword_path(@keyword, pane: params[:pane])
# end
