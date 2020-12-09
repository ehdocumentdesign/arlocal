class Public::InfoController < PublicController

  def show
    @info_page = QueryInfoPage.new.get
  end

end
