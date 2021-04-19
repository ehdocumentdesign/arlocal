class Public::AlbumsController < PublicController


  def index
    if params[:filter] == nil
      params[:filter] = SorterIndexPublicAlbums.find(@arlocal_settings.public_index_albums_sorter_id).symbol
    end
    @albums = QueryAlbums.new(arlocal_settings: @arlocal_settings, params: params).action_public_index
  end


  def show
    @album = QueryAlbums.find_public(params[:id])
    @album_neighbors = QueryAlbums.new(arlocal_settings: @arlocal_settings).action_public_show_neighborhood(@album)
  end


end
