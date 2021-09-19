class Admin::InfoController < AdminController


  def edit
    @info_page = QueryInfoPage.get
    @form_metadata = FormInfoMetadata.new(pane: params[:pane], settings: @arlocal_settings)
  end


  def new_contact
    redirect_to action: :edit
  end


  def show
    @info_page = QueryInfoPage.get
  end


  def update
    @info_page = QueryInfoPage.get
    if @info_page.update(params_info_page_permitted)
      flash[:notice] = 'Info Page was successfuly updated.'
      redirect_to edit_admin_info_path(pane: params[:pane])
    else
      @form_metadata = FormInfoMetadata.new(pane: params[:pane], settings: @arlocal_settings)
      flash[:notice] = 'Info Page could not be updated.'
      render 'edit'
    end
  end



  private


  def params_info_page_permitted
    params.require(:info_page).permit(
      :article_id,
      :picture_id,
      info_page_links_attributes: [
        :display_method,
        :link_id,
        :id,
        :info_page_can_display_details,
        :info_page_order,
        :_destroy
      ]
    )
  end



end
