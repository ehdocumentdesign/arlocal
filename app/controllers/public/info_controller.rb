class Public::InfoController < PublicController

  # def show
  #   @info_page = QueryInfoPage.get
  # end


  def show
    @info_page = QueryInfopage.get
  end


end
