class Admin::KeywordsController < AdminController


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
    @keyword = QueryKeywords.find(params[:id])
    @keyword.destroy
    flash[:notice] = 'Keyword was destroyed.'
    redirect_to action: :index
  end


  def edit
    @keyword = QueryKeywords.find(params[:id])
    @keyword_neighbors = QueryKeywords.new(arlocal_settings: @arlocal_settings).action_admin_show_neighborhood(@keyword)
    @form_metadata = FormKeywordMetadata.new(pane: params[:pane], settings: @arlocal_settings)
  end


  def index
    @keywords = QueryKeywords.new.action_admin_index
  end


  def new
    @keyword = KeywordBuilder.default
    @form_metadata = FormKeywordMetadata.new
  end


  def show
    @keyword = QueryKeywords.find(params[:id])
    @keyword_neighbors = QueryKeywords.new(arlocal_settings: @arlocal_settings).action_admin_show_neighborhood(@keyword)
  end


  # def unkeyword_albums
  #   @keyword = QueryKeywords.new.find(params[:id])
  #   AlbumKeyword.where({keyword_id: @keyword.id}).each { |at| at.destroy }
  #   flash[:notice] = 'Albums were unkeyworded.'
  #   redirect_to edit_admin_keyword_path(@keyword, pane: params[:pane])
  # end
  #
  #
  # def unkeyword_audio
  #   @keyword = QueryKeywords.new.find(params[:id])
  #   AudioKeyword.where({keyword_id: @keyword.id}).each { |at| at.destroy }
  #   flash[:notice] = 'Audio was unkeyworded.'
  #   redirect_to edit_admin_keyword_path(@keyword, pane: params[:pane])
  # end
  #
  #
  # def unkeyword_events
  #   @keyword = QueryKeywords.new.find(params[:id])
  #   EventKeyword.where({keyword_id: @keyword.id}).each { |et| et.destroy }
  #   flash[:notice] = 'Events were unkeyworded.'
  #   redirect_to edit_admin_keyword_path(@keyword, pane: params[:pane])
  # end
  #
  #
  # def unkeyword_pictures
  #   @keyword = QueryKeywords.new.find(params[:id])
  #   PictureKeyword.where({keyword_id: @keyword.id}).each { |pt| pt.destroy }
  #   flash[:notice] = 'Pictures were unkeyworded.'
  #   redirect_to edit_admin_keyword_path(@keyword, pane: params[:pane])
  # end


  def update
    @keyword = QueryKeywords.find(params[:id])
    if @keyword.update_and_recount_joined_resources(params_keyword_permitted)
      flash[:notice] = 'Keyword was successfully updated.'
      redirect_to edit_admin_keyword_path(@keyword.id_admin, pane: params[:pane])
    else
      @form_metadata = FormKeywordMetadata.new(pane: params[:pane], settings: @arlocal_settings)
      flash[:notice] = 'Keyword could not be updated.'
      render 'edit'
    end
  end



  private


  def params_keyword_permitted
    params.require(:keyword).permit(
      :can_select_public_albums,
      :can_select_pictures,
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
