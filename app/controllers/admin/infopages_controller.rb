class Admin::InfopagesController < AdminController


  def edit
    @infopage = QueryInfopages.get
    @form_metadata = FormInfopageMetadata.new(pane: params[:pane], settings: @arlocal_settings)
  end


  # def new_contact
  #   redirect_to action: :edit
  # end


  def show
    @infopage = QueryInfopages.get
  end


  def update
    @infopage = QueryInfopages.get
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
