class Admin::InfopagesController < AdminController


  def create
    @infopage = InfopageBuilder.create(params_infopage_permitted)
    if @infopage.save
      flash[:notice] = 'Info Page was successfully created.'
      redirect_to edit_admin_infopage_path(@infopage.id_admin)
    else
      @form_metadata = FormInfopageMetadata.new(pane: params[:pane], arlocal_settings: @arlocal_settings)
      if @arlocal_settings.admin_forms_auto_keyword_enabled
        @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      end
      flash[:notice] = 'Info Page could not be created.'
      render 'new'
    end
  end


  def destroy
  @infopage = QueryInfopages.find_admin(params[:id])
  @infopage.destroy
  flash[:notice] = 'Info Page was destroyed.'
  redirect_to action: :index
end


  def edit
    @infopage = QueryInfopages.find_admin(params[:id])
    @infopage_neighbors = QueryInfopages.neighborhood_admin(@infopage, @arlocal_settings)
    @form_metadata = FormInfopageMetadata.new(pane: params[:pane], settings: @arlocal_settings)
  end


  def index
    @infopages = QueryInfopages.index_admin
  end


  def new
    @infopage = InfopageBuilder.build_with_defaults
    @form_metadata = FormInfopageMetadata.new(pane: params[:pane], settings: @arlocal_settings)
    if @arlocal_settings.admin_forms_auto_keyword_enabled
      @auto_keyword = AutoKeywordMetadata.new(@arlocal_settings)
      @infopage.infopage_keywords.build(keyword_id: @auto_keyword.keyword_id)
    end
  end


  def show
    @infopage = QueryInfopages.find_admin(params[:id])
    @infopage_neighbors = QueryInfopages.neighborhood_admin(@infopage, @arlocal_settings)
  end


  def update
    @infopage = QueryInfopages.find_admin(params[:id])
    if @infopage.update(params_infopage_permitted)
      flash[:notice] = 'Info Page was successfuly updated.'
      redirect_to edit_admin_infopage_path(pane: params[:pane])
    else
      @form_metadata = FormInfopageMetadata.new(pane: params[:pane], settings: @arlocal_settings)
      flash[:notice] = 'Info Page could not be updated.'
      render 'edit'
    end
  end



  private


  def params_infopage_permitted
    params.require(:infopage).permit(
      :index_order,
      :title,
      infopage_articles_attributes: [
        :id,
        :infopage_id,
        :infopage_group,
        :infopage_group_order,
        :infopageable_id,
        :infopageable_type,
        :_destroy
      ],
      infopage_items_attributes: [
        :id,
        :infopage_id,
        :infopage_group,
        :infopage_group_order,
        :infopageable_id,
        :infopageable_type,
        :_destroy
      ],
      infopage_links_attributes: [
        :id,
        :infopage_id,
        :infopage_group,
        :infopage_group_order,
        :infopageable_id,
        :infopageable_type,
        :_destroy
      ],
      infopage_pictures_attributes: [
        :id,
        :infopage_id,
        :infopage_group,
        :infopage_group_order,
        :infopageable_id,
        :infopageable_type,
        :_destroy
      ]

    )
  end



end
