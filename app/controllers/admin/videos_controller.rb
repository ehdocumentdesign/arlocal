class Admin::VideosController < AdminController


  def edit
    @video = Video.new
    @form_metadata = FormVideoMetadata.new(pane: params[:pane])
  end


  def show
    @video = Video.new
  end


end
