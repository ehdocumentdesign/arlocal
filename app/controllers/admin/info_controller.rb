class Admin::InfoController < AdminController


  def edit
    @info_page = QueryInfopage.get
    @form_metadata = FormInfoMetadata.new(pane: params[:pane], settings: @arlocal_settings)
  end


  # def new_contact
  #   redirect_to action: :edit
  # end


  def show
    @info_page = QueryInfopage.get
  end


  def update
    @info_page = QueryInfopage.get
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
    params.require(:infopage).permit(
      infopage_items_attributes: [
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
