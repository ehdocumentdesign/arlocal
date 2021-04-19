class Public::InfoController < PublicController

  def show
    @info_page = QueryInfoPage.get
  end

end
