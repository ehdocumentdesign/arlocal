class Public::InfopagesController < PublicController


  def first
    @infopage = QueryInfopages.get
    render action: :show
  end


  def show
    @infopage = QueryInfopages.get
  end


end
