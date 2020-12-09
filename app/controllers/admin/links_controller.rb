class Admin::LinksController < AdminController


  def create
    @link = Link.new(link_params)
    if @link.save
      flash[:notice] = 'Link successfully created and added.'
      redirect_to admin_links_path
    else
      @form_metadata = FormLinkMetadata.new(pane: params[:pane])
      flash[:notice] = 'Link could not be created.'
      render 'new'
    end
  end


  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    flash[:notice] = 'Link was destroyed.'
    redirect_to action: :index
  end


  def edit
    @link = Link.find(params[:id])
    @link_neighbors = QueryLinks.new(arlocal_settings: @arlocal_settings).action_admin_show_neighborhood(@link)
    @form_metadata = FormLinkMetadata.new(pane: params[:pane])
  end


  def index
    @links = Link.all
  end


  def new
    @link = LinkBuilder.new.default
    @form_metadata = FormLinkMetadata.new(pane: params[:pane])
  end


  def show
    @link = Link.find(params[:id])
    @link_neighbors = QueryLinks.new(arlocal_settings: @arlocal_settings).action_admin_show_neighborhood(@link)
  end


  def update
    @link = Link.find(params[:id])
    if @link.update(link_params)
      flash[:notice] = 'Link was successfully updated.'
      redirect_to edit_admin_link_path(@link.id)
    else
      @form_metadata = FormLinkMetadata.new(pane: params[:pane])
      flash[:notice] = 'Link could not be updated.'
      render 'edit'
    end
  end



  private


  def link_params
    params.require(:link).permit(
      :address_href,
      :address_inline_text,
      :details_parser_id,
      :details_text_markup,
      :name
    )
  end


end
