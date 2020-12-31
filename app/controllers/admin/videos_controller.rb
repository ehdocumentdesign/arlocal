class Admin::VideosController < AdminController


  def edit
    @video = Video.new
    @form_metadata = FormVideoMetadata.new(pane: params[:pane], settings: @arlocal_settings)
  end


  def show
    @video = Video.new
  end


end
