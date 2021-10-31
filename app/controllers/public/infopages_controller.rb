class Public::InfopagesController < PublicController


  def first
    @infopage = QueryInfopages.first_public
    render action: :show
  end


  def show
    @infopage = QueryInfopages.find_public(params[:id])
  end


end
